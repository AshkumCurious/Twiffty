# 🐦 Twiffty Game

A Flutter Flappy Bird game with clean MVC + Provider architecture.

---

## 🏗️ Architecture: MVC + Provider

| Layer | Responsibility |
|---|---|
| **Model** (`GameModel`) | Immutable data snapshot — bird position, barrier positions, scores, game state |
| **Controller** (`GameController`) | Game loop (Timer), physics, collision detection, score persistence |
| **View** (pages + widgets) | Pure UI — reads from `context.watch<GameController>()`, calls controller methods on tap |

The `GameController` extends `ChangeNotifier`. Every ~16 ms tick updates the model and calls `notifyListeners()`. Views rebuild automatically.

---

## 🎮 Gameplay

- Tap anywhere to make the bird flap
- Navigate through the gaps between pipes
- Each pipe pair passed = +1 score
- Difficulty increases every 5 points (pipes move faster)
- Best score is saved across sessions
