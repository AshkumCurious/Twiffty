import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../controllers/game_controller.dart';
import '../../models/game_model.dart';
import '../widgets/bird_widget.dart';
import '../widgets/barrier_widget.dart';
import '../widgets/score_board_widget.dart';
import '../widgets/game_over_overlay.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<GameController>().resetGame();
      }
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<GameController>();
    final model = ctrl.model;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (model.gameState == GameState.idle) {
          ctrl.startGame();
        } else if (model.gameState == GameState.playing) {
          ctrl.jump();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  _buildBackground(),
                  _buildBarrierPair(
                    context,
                    bx: model.barrierOneX,
                    gapY: model.barrierOneGapY,
                  ),
                  _buildBarrierPair(
                    context,
                    bx: model.barrierTwoX,
                    gapY: model.barrierTwoGapY,
                  ),
                  AnimatedContainer(
                    duration: Duration.zero,
                    alignment: Alignment(0, model.birdY),
                    child: const BirdWidget(),
                  ),
                  if (model.gameState == GameState.idle) _buildTapHint(),
                  if (model.gameState == GameState.playing)
                    _buildInGameScore(model.score),
                  const GameOverOverlay(),
                ],
              ),
            ),
            Container(
              height: 18,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF27AE60), Color(0xFF1E8449)],
                ),
              ),
            ),
            const ScoreBoardWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF87CEEB),
            Color(0xFFB0E2FF),
            Color(0xFFD4F1F9),
          ],
        ),
      ),
      child: const Stack(
        children: [
          Positioned(
            top: 60,
            left: 40,
            child: _Cloud(size: 60, opacity: 0.8),
          ),
          Positioned(
            top: 120,
            right: 30,
            child: _Cloud(size: 40, opacity: 0.6),
          ),
          Positioned(
            top: 200,
            left: 120,
            child: _Cloud(size: 50, opacity: 0.5),
          ),
        ],
      ),
    );
  }

  Widget _buildBarrierPair(
    BuildContext context, {
    required double bx,
    required double gapY,
  }) {
    final screenH = MediaQuery.of(context).size.height * 0.75;
    final screenW = MediaQuery.of(context).size.width;

    final centerX = (bx + 1) / 2 * screenW;
    final centerY = (gapY + 1) / 2 * screenH;
    final barrierW = GameModel.barrierWidth / 2 * screenW;
    final gapHalf = GameModel.gapSize / 2 * screenH;

    final topH = centerY - gapHalf;
    final bottomH = screenH - (centerY + gapHalf);

    return Stack(
      children: [
        if (topH > 0)
          Positioned(
            left: centerX - barrierW,
            top: 0,
            width: barrierW * 2,
            height: topH,
            child: const BarrierWidget(isTop: true),
          ),
        if (bottomH > 0)
          Positioned(
            left: centerX - barrierW,
            bottom: 0,
            width: barrierW * 2,
            height: bottomH,
            child: const BarrierWidget(isTop: false),
          ),
      ],
    );
  }

  Widget _buildTapHint() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.45),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.touch_app_rounded,
                color: Colors.white70, size: 20),
            const SizedBox(width: 10),
            Text(
              'TAP TO FLY',
              style: GoogleFonts.orbitron(
                color: Colors.white,
                fontSize: 15,
                letterSpacing: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInGameScore(int score) {
    return Positioned(
      top: 20,
      left: 0,
      right: 0,
      child: Center(
        child: Text(
          score.toString(),
          style: GoogleFonts.orbitron(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.bold,
            shadows: [
              const Shadow(
                color: Colors.black45,
                offset: Offset(2, 2),
                blurRadius: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Cloud extends StatelessWidget {
  final double size;
  final double opacity;

  const _Cloud({required this.size, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Container(
        width: size * 2,
        height: size * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(size),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.5),
              blurRadius: 15,
            ),
          ],
        ),
      ),
    );
  }
}
