class GameModel {
  double birdY;
  double birdVelocity;
  double barrierOneX;
  double barrierTwoX;
  double barrierOneGapY;
  double barrierTwoGapY;
  int score;
  int bestScore;
  GameState gameState;
  int selectedAvatar;
  double barrierSpeed;
  double gravity;

  static const double gapSize = 0.45; 
  static const double barrierWidth = 0.12;
  static const double birdSize = 0.07;

  GameModel({
    this.birdY = 0.0,
    this.birdVelocity = 0.0,
    this.barrierOneX = 1.5,
    this.barrierTwoX = 3.0,
    this.barrierOneGapY = 0.0,
    this.barrierTwoGapY = 0.3,
    this.score = 0,
    this.bestScore = 0,
    this.gameState = GameState.idle,
    this.selectedAvatar = 1,
    this.barrierSpeed = 0.025,
    this.gravity = 0.004,
  });

  GameModel copyWith({
    double? birdY,
    double? birdVelocity,
    double? barrierOneX,
    double? barrierTwoX,
    double? barrierOneGapY,
    double? barrierTwoGapY,
    int? score,
    int? bestScore,
    GameState? gameState,
    int? selectedAvatar,
    double? barrierSpeed,
    double? gravity,
  }) {
    return GameModel(
      birdY: birdY ?? this.birdY,
      birdVelocity: birdVelocity ?? this.birdVelocity,
      barrierOneX: barrierOneX ?? this.barrierOneX,
      barrierTwoX: barrierTwoX ?? this.barrierTwoX,
      barrierOneGapY: barrierOneGapY ?? this.barrierOneGapY,
      barrierTwoGapY: barrierTwoGapY ?? this.barrierTwoGapY,
      score: score ?? this.score,
      bestScore: bestScore ?? this.bestScore,
      gameState: gameState ?? this.gameState,
      selectedAvatar: selectedAvatar ?? this.selectedAvatar,
      barrierSpeed: barrierSpeed ?? this.barrierSpeed,
      gravity: gravity ?? this.gravity,
    );
  }
}

enum GameState { idle, playing, dead }
