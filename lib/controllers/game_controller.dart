import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/game_model.dart';

class GameController extends ChangeNotifier {
  GameModel _model = GameModel();
  Timer? _gameTimer;
  final Random _random = Random();

  static const double _baseSpeed = 0.025;
  static const double _speedIncrement = 0.002;
  static const double _jumpVelocity = -0.045;
  static const double _gravity = 0.004;
  static const double _tickMs = 16; // ~60fps

  GameModel get model => _model;

  GameController() {
    _loadBestScore();
  }

  Future<void> _loadBestScore() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getInt('best_score') ?? 0;
    _model = _model.copyWith(bestScore: saved);
    notifyListeners();
  }

  Future<void> _saveBestScore(int score) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('best_score', score);
  }

  void selectAvatar(int avatarIndex) {
    _model = _model.copyWith(selectedAvatar: avatarIndex);
    notifyListeners();
  }

  void startGame() {
    if (_model.gameState == GameState.playing) return;
    _resetPositions();
    _model = _model.copyWith(gameState: GameState.playing, score: 0);
    notifyListeners();
    _startLoop();
  }

  void jump() {
    if (_model.gameState != GameState.playing) return;
    _model = _model.copyWith(birdVelocity: _jumpVelocity);
    notifyListeners();
  }

  void _startLoop() {
    _gameTimer?.cancel();
    _gameTimer = Timer.periodic(
      Duration(milliseconds: _tickMs.toInt()),
      (_) => _tick(),
    );
  }

  void _tick() {
    if (_model.gameState != GameState.playing) return;

    final newVelocity = _model.birdVelocity + _gravity;
    final newBirdY = _model.birdY + newVelocity;

    final speed = _baseSpeed + (_model.score ~/ 5) * _speedIncrement;

    double b1x = _model.barrierOneX - speed;
    double b2x = _model.barrierTwoX - speed;
    double b1GapY = _model.barrierOneGapY;
    double b2GapY = _model.barrierTwoGapY;
    int newScore = _model.score;

    if (b1x < -1.3) {
      b1x += 3.0;
      b1GapY = (_random.nextDouble() * 1.2) - 0.6;
      newScore++;
    }
    if (b2x < -1.3) {
      b2x += 3.0;
      b2GapY = (_random.nextDouble() * 1.2) - 0.6;
      newScore++;
    }

    int bestScore = _model.bestScore;
    if (newScore > bestScore) {
      bestScore = newScore;
      _saveBestScore(bestScore);
    }

    _model = _model.copyWith(
      birdY: newBirdY,
      birdVelocity: newVelocity,
      barrierOneX: b1x,
      barrierTwoX: b2x,
      barrierOneGapY: b1GapY,
      barrierTwoGapY: b2GapY,
      score: newScore,
      bestScore: bestScore,
    );

    if (_checkCollision()) {
      _killBird();
      return;
    }

    notifyListeners();
  }

  bool _checkCollision() {
    if (_model.birdY > 1.1 || _model.birdY < -1.1) return true;

    const double birdLeft = -0.08;
    const double birdRight = 0.08;
    const double birdHalf = 0.07;

    for (int i = 0; i < 2; i++) {
      final bx = i == 0 ? _model.barrierOneX : _model.barrierTwoX;
      final gapY = i == 0 ? _model.barrierOneGapY : _model.barrierTwoGapY;

      if (_model.birdY.abs() < 1.2) {
        final bLeft = bx - GameModel.barrierWidth / 2;
        final bRight = bx + GameModel.barrierWidth / 2;
        const birdX = 0.0;

        if (birdX + birdRight > bLeft && birdX + birdLeft < bRight) {
          final gapTop = gapY - GameModel.gapSize / 2;
          final gapBottom = gapY + GameModel.gapSize / 2;

          if (_model.birdY - birdHalf < gapTop ||
              _model.birdY + birdHalf > gapBottom) {
            return true;
          }
        }
      }
    }
    return false;
  }

  void _killBird() {
    _gameTimer?.cancel();
    _model = _model.copyWith(gameState: GameState.dead);
    notifyListeners();
  }

  void resetGame() {
    _gameTimer?.cancel();
    _resetPositions();
    _model = _model.copyWith(
      gameState: GameState.idle,
      score: 0,
    );
    notifyListeners();
  }

  void _resetPositions() {
    _model = _model.copyWith(
      birdY: 0.0,
      birdVelocity: 0.0,
      barrierOneX: 1.5,
      barrierTwoX: 3.0,
      barrierOneGapY: _random.nextDouble() * 0.8 - 0.4,
      barrierTwoGapY: _random.nextDouble() * 0.8 - 0.4,
    );
  }

  @override
  void dispose() {
    _gameTimer?.cancel();
    super.dispose();
  }
}
