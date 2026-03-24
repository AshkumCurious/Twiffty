import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/game_controller.dart';
import '../../models/app_constants.dart';
import '../../models/game_model.dart';

class BirdWidget extends StatelessWidget {
  const BirdWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<GameController>();
    final model = ctrl.model;

    final tiltAngle = (model.birdVelocity * 4).clamp(-0.6, 1.0);

    return Transform.rotate(
      angle: tiltAngle,
      child: Image.asset(
        AppConstants.avatarAssets[model.selectedAvatar - 1],
        height: 60,
        width: 60,
        fit: BoxFit.contain,
      ),
    );
  }
}
