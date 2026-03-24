import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../controllers/game_controller.dart';
import '../../models/game_model.dart';

class GameOverOverlay extends StatelessWidget {
  const GameOverOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<GameController>();
    final model = ctrl.model;

    if (model.gameState != GameState.dead) return const SizedBox.shrink();

    return Container(
      color: Colors.black.withValues(alpha: 0.75),
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 28),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1A1A2E), Color(0xFF0F3460)],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white12, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 30,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Animated skull icon
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFE74C3C).withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.sentiment_very_dissatisfied_rounded,
                  color: Color(0xFFE74C3C),
                  size: 50,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'GAME OVER',
                style: GoogleFonts.orbitron(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
              ),
              const SizedBox(height: 24),
              // Scores row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _ResultTile(
                    label: 'SCORE',
                    value: model.score.toString(),
                    color: const Color(0xFFF39C12),
                  ),
                  Container(width: 1, height: 50, color: Colors.white12),
                  _ResultTile(
                    label: 'BEST',
                    value: model.bestScore.toString(),
                    color: const Color(0xFF2ECC71),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              // Buttons row
              Row(
                children: [
                  Expanded(
                    child: _ActionButton(
                      label: 'RETRY',
                      icon: Icons.replay_rounded,
                      color: const Color(0xFF2ECC71),
                      onTap: () => ctrl.startGame(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _ActionButton(
                      label: 'MENU',
                      icon: Icons.home_rounded,
                      color: const Color(0xFF3498DB),
                      onTap: () {
                        ctrl.resetGame();
                        Navigator.of(context).popUntil((r) => r.isFirst);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResultTile extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _ResultTile({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: GoogleFonts.orbitron(
            color: Colors.white38,
            fontSize: 11,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.orbitron(
            color: color,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withValues(alpha: 0.5), width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.orbitron(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
