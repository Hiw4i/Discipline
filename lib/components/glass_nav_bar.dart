import 'package:flutter/material.dart';
import 'dart:ui';
import 'animated_icon_button.dart';

class GlassNavBar extends StatelessWidget {
  final VoidCallback onHomeTap;
  final VoidCallback onDevelopmentTap;
  final VoidCallback onStatisticsTap;
  final VoidCallback onSettingsTap;
  final int currentIndex;
  
  const GlassNavBar({
      super.key,
      required this.onHomeTap,
      required this.onDevelopmentTap,
      required this.onStatisticsTap,
      required this.onSettingsTap,
      required this.currentIndex,
    });


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isDesktop = width > 800;

    return Padding(
      
      padding: const EdgeInsets.only(bottom: 30, right: 20, left: 20),
      child: isDesktop
        ? Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // _glassCircle(context),
            // const SizedBox(height: 9),
            _glassPill(context, isDesktop),
          ]
        )
        : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // _glassCircle(context),
            // const SizedBox(width: 9),
            _glassPill(context, isDesktop),
          ],

      ),
      
    );
  }

  // Widget _glassCircle(BuildContext context) {
  //   final ColorScheme colorScheme = Theme.of(context).colorScheme;

  //   return ClipOval(
  //     child: BackdropFilter(

  //       filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
  //       child: Container(
  //         width: 60,
  //         height: 60,
  //         padding: const EdgeInsets.all(7),
  //         decoration: BoxDecoration(
  //           color: colorScheme.primaryContainer.withValues(alpha: 0.3),
  //           shape: BoxShape.circle,
  //           border: Border.all(color: colorScheme.onPrimaryContainer.withValues(alpha: 0.2)),
  //         ),
  //         child: AnimatedIconButton(
  //                 icon: Icons.home_rounded,
  //                 onTap: onHomeTap,
  //                 isSelected: currentIndex == 0,
  //               ),
  //       ),

  //     ),
  //   );
  // }

  Widget _glassPill(BuildContext context, bool isDesktop) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final buttons = [
      AnimatedIconButton(icon: Icons.home_rounded, onTap: onHomeTap, isSelected: currentIndex == 0),
      AnimatedIconButton(icon: Icons.medication_rounded, onTap: onDevelopmentTap, isSelected: currentIndex == 1),
      AnimatedIconButton(icon: Icons.route_outlined, onTap: onStatisticsTap, isSelected: currentIndex == 2),
      AnimatedIconButton(icon: Icons.settings_rounded, onTap: onSettingsTap, isSelected: currentIndex == 3),
    ];

    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(

        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(

          width: isDesktop ? 60 : 216,
          height: isDesktop ? 216 : 60,
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: colorScheme.onPrimaryContainer.withValues(alpha: 0.2)),
          ),
          child: isDesktop
            ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: buttons,
            )
            : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: buttons,
            )
          
        ),
      ),
    );
  }

}