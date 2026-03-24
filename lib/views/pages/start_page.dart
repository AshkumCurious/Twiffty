import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../controllers/game_controller.dart';
import '../../models/app_constants.dart';
import 'home_page.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<GameController>();
    final avatarIdx = ctrl.model.selectedAvatar - 1;
    final avatarColor = AppConstants.avatarColors[avatarIdx];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0A0E27),
              Color(0xFF1A1A4E),
              Color(0xFF0D3B6E),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Avatar display with glow
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: avatarColor.withValues(alpha: 0.12),
                    boxShadow: [
                      BoxShadow(
                        color: avatarColor.withValues(alpha: 0.4),
                        blurRadius: 40,
                        spreadRadius: 10,
                      ),
                    ],
                    border: Border.all(
                      color: avatarColor.withValues(alpha: 0.4),
                      width: 2,
                    ),
                  ),
                  child: Image.asset(
                    AppConstants.avatarAssets[avatarIdx],
                    height: 130,
                    width: 130,
                    errorBuilder: (_, __, ___) => Icon(
                      Icons.flutter_dash,
                      size: 120,
                      color: avatarColor,
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                Text(
                  AppConstants.avatarNames[avatarIdx].toUpperCase(),
                  style: GoogleFonts.orbitron(
                    color: avatarColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'is ready to fly!',
                  style: GoogleFonts.orbitron(
                    color: Colors.white60,
                    fontSize: 14,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 60),
                if (ctrl.model.bestScore > 0) ...[
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.emoji_events_rounded,
                            color: Color(0xFFF1C40F), size: 16),
                        const SizedBox(width: 8),
                        Text(
                          'Best: ${ctrl.model.bestScore}',
                          style: GoogleFonts.orbitron(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const HomePage(),
                        transitionsBuilder: (_, anim, __, child) =>
                            FadeTransition(opacity: anim, child: child),
                        transitionDuration: const Duration(milliseconds: 400),
                      ),
                    );
                  },
                  child: Container(
                    width: 200,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          avatarColor,
                          avatarColor.withValues(alpha: 0.7),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: avatarColor.withValues(alpha: 0.4),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.play_arrow_rounded,
                            color: Colors.white, size: 22),
                        const SizedBox(width: 8),
                        Text(
                          'START',
                          style: GoogleFonts.orbitron(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    '← Change Avatar',
                    style: GoogleFonts.orbitron(
                      color: Colors.white38,
                      fontSize: 12,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
