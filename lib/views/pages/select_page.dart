import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../controllers/game_controller.dart';
import '../../models/app_constants.dart';
import 'start_page.dart';

class SelectPage extends StatefulWidget {
  const SelectPage({Key? key}) : super(key: key);

  @override
  State<SelectPage> createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  int _hoveredIndex = -1;

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            children: [
              const SizedBox(height: 30),
              _buildLogo(),
              const SizedBox(height: 10),
              Text(
                'Choose Your Twiffy',
                style: GoogleFonts.orbitron(
                  color: Colors.white60,
                  fontSize: 14,
                  letterSpacing: 3,
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: _buildAvatarGrid(),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            5,
            (i) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Icon(
                Icons.star_rounded,
                color: Colors.yellow.withValues(alpha: 0.6),
                size: 12,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFFFFD700), Color(0xFFFFA500), Color(0xFFFF6B35)],
          ).createShader(bounds),
          child: Text(
            'TWIFFTY',
            style: GoogleFonts.orbitron(
              fontSize: 44,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 8,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAvatarGrid() {
    final ctrl = context.watch<GameController>();

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.85,
      ),
      itemCount: AppConstants.avatarAssets.length,
      itemBuilder: (context, i) {
        final isSelected = ctrl.model.selectedAvatar == i + 1;
        final color = AppConstants.avatarColors[i];

        return GestureDetector(
          onTap: () {
            ctrl.selectAvatar(i + 1);
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => const StartPage(),
                transitionsBuilder: (_, anim, __, child) =>
                    FadeTransition(opacity: anim, child: child),
                transitionDuration: const Duration(milliseconds: 300),
              ),
            );
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isSelected
                    ? [
                        color.withValues(alpha: 0.4),
                        color.withValues(alpha: 0.15),
                      ]
                    : [
                        Colors.white.withValues(alpha: 0.08),
                        Colors.white.withValues(alpha: 0.03),
                      ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected ? color : Colors.white12,
                width: isSelected ? 2 : 1,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: color.withValues(alpha: 0.3),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ]
                  : [],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isSelected)
                  Icon(Icons.check_circle_rounded, color: color, size: 20),
                const SizedBox(height: 4),
                Image.asset(
                  AppConstants.avatarAssets[i],
                  height: 90,
                  width: 90,
                  errorBuilder: (_, __, ___) => Icon(
                    Icons.flutter_dash,
                    size: 80,
                    color: color,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  AppConstants.avatarNames[i],
                  style: GoogleFonts.orbitron(
                    color: isSelected ? color : Colors.white70,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
