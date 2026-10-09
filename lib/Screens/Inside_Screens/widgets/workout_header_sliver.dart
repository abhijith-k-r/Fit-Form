import 'dart:io';

import 'package:fit_form/App_Colors/app_colors.dart';
import 'package:fit_form/functions/addworkouts.dart';
import 'package:fit_form/models/workouts_model.dart';
import 'package:flutter/material.dart';

class WorkoutHeaderSliver extends StatefulWidget {
  const WorkoutHeaderSliver({
    super.key,
    required this.work,
    required this.isDarkMode,
  });

  final WorkoutsModel? work;
  final bool isDarkMode;

  @override
  State<WorkoutHeaderSliver> createState() => _WorkoutHeaderSliverState();
}

class _WorkoutHeaderSliverState extends State<WorkoutHeaderSliver> {
  ImageProvider _getImageProvider(String? imagePath, String? difficulty) {
    if (imagePath != null && imagePath.isNotEmpty) {
      if (imagePath.startsWith('asset/') || imagePath.startsWith('assets/')) {
        return AssetImage(imagePath);
      }
      final file = File(imagePath);
      if (file.existsSync()) {
        return FileImage(file);
      }
    }
    if (difficulty == 'Intermediate') {
      return const AssetImage('asset/Work_Outs_Images/IntermediateAi.webp');
    } else if (difficulty == 'Advanced') {
      return const AssetImage('asset/Work_Outs_Images/AdvancedAi.webp');
    }
    return const AssetImage('asset/Work_Outs_Images/BeginnerAi.webp');
  }

  @override
  Widget build(BuildContext context) {
    final btnBg =
        (widget.isDarkMode ? Colors.black : Colors.white).withValues(alpha: 0.8);

    return SliverAppBar(
      expandedHeight: 280,
      pinned: true,
      elevation: 2,
      backgroundColor: widget.isDarkMode ? appcolorblack : appcolorwhite,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(color: btnBg, shape: BoxShape.circle),
          child: Icon(Icons.arrow_back_ios_new, color: appcolorRed, size: 18),
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: [
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(color: btnBg, shape: BoxShape.circle),
            child: Icon(
              widget.work?.favorite == true
                  ? Icons.favorite
                  : Icons.favorite_outline_rounded,
              color: appcolorRed,
              size: 20,
            ),
          ),
          onPressed: () async {
            setState(() {
              widget.work?.favorite = !(widget.work?.favorite ?? false);
            });
            if (widget.work?.id != null) {
              await editWorkout(widget.work!.id!, widget.work!);
            }
          },
        ),
        const SizedBox(width: 8),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image(
              image: _getImageProvider(
                widget.work?.workoutsImage,
                widget.work?.difficulty,
              ),
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Image.asset(
                'asset/Work_Outs_Images/BeginnerAi.webp',
                fit: BoxFit.cover,
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.4),
                    Colors.transparent,
                    (widget.isDarkMode ? appcolorblack : appcolorwhite)
                        .withValues(alpha: 0.9),
                  ],
                  stops: const [0.0, 0.6, 1.0],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
