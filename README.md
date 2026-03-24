# 🐦 Twiffty Game — Revamped

A polished Flutter Flappy Bird revamp with clean MVC + Provider architecture.

---

## 📁 Project Structure

```
lib/
├── main.dart                        # Entry point + Provider setup
│
├── models/
│   ├── game_model.dart              # Pure data: bird pos, barriers, score, state
│   └── app_constants.dart           # Avatar assets, names, colours
│
├── controllers/
│   └── game_controller.dart        # ChangeNotifier: all game logic
│
└── views/
    ├── pages/
    │   ├── select_page.dart         # Avatar selection grid
    │   ├── start_page.dart          # Avatar confirmation + start
    │   └── home_page.dart           # Main gameplay screen
    │
    └── widgets/
        ├── bird_widget.dart         # Bird with velocity-based tilt
        ├── barrier_widget.dart      # Styled green pipe
        ├── score_board_widget.dart  # Score + Best score panel
        └── game_over_overlay.dart   # Death screen with retry/menu
```

---

## 🏗️ Architecture: MVC + Provider

| Layer | Responsibility |
|---|---|
| **Model** (`GameModel`) | Immutable data snapshot — bird position, barrier positions, scores, game state |
| **Controller** (`GameController`) | Game loop (Timer), physics, collision detection, score persistence |
| **View** (pages + widgets) | Pure UI — reads from `context.watch<GameController>()`, calls controller methods on tap |

The `GameController` extends `ChangeNotifier`. Every ~16 ms tick updates the model and calls `notifyListeners()`. Views rebuild automatically.

---

## ✨ What's New vs Original

| Feature | Before | After |
|---|---|---|
| Architecture | Global variables + setState | MVC + Provider |
| Score persistence | Session only | `SharedPreferences` (survives restarts) |
| Collision detection | Only floor/ceiling | Floor/ceiling + barrier hit-boxes |
| Barriers | Fixed size, 2 barriers | Randomised gap position, difficulty ramps up |
| Bird physics | Basic parabola | Velocity + gravity each tick, visual tilt |
| Barrier rendering | Thin fixed-size boxes | Proper pipes with cap and shadow |
| Orientation | Unspecified | Portrait locked + immersive fullscreen |
| Game over | AlertDialog | Full overlay with score summary |
| UI theme | Plain blue + orange | Dark space theme with glow effects |
| Navigation | Direct push | Smooth fade transitions |
| Avatar selection | Horizontal scroll row | Grid with selection highlight + glow |

---

## 🚀 Setup

```bash
flutter pub get
flutter run
```

Requires Flutter 3.x and Dart ≥ 2.18.

Place your avatar images at:
```
lib/images/twiffyBrown.png
lib/images/twiffyGreen.png
lib/images/twiffyBlue.png
lib/images/twiffyPink.png
lib/images/twiffyYellow.png
lib/images/start.png
```

---

## 🎮 Gameplay

- Tap anywhere to make the bird flap
- Navigate through the gaps between pipes
- Each pipe pair passed = +1 score
- Difficulty increases every 5 points (pipes move faster)
- Best score is saved across sessions
