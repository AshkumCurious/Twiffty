import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../controllers/game_controller.dart';

class ScoreBoardWidget extends StatelessWidget {
  const ScoreBoardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<GameController>();
    final model = ctrl.model;

    return Container(
      height: 110,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _ScoreTile(
            label: 'SCORE',
            value: model.score.toString(),
            icon: Icons.star_rounded,
            color: const Color(0xFFF39C12),
          ),
          Container(
            width: 1,
            height: 60,
            color: Colors.white.withValues(alpha:  0.15),
          ),
          _ScoreTile(
            label: 'BEST',
            value: model.bestScore.toString(),
            icon: Icons.emoji_events_rounded,
            color: const Color(0xFFE74C3C),
          ),
        ],
      ),
    );
  }
}

class _ScoreTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _ScoreTile({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 16),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.orbitron(
                color: Colors.white60,
                fontSize: 11,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: GoogleFonts.orbitron(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
