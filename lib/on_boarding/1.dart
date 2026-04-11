import 'package:flutter/material.dart';
import 'package:ascend/components/animated_text_button.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/services.dart';
import 'package:ascend/on_boarding/2.dart';

class OnboardingScreen1 extends StatefulWidget {
  const OnboardingScreen1({super.key});

  @override
  State<OnboardingScreen1> createState() => _OnboardingScreen1State();
}

class _OnboardingScreen1State extends State<OnboardingScreen1> {

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [

            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontFamily: 'JetBrainsMono',
                          fontSize: 22,
                          color: colorScheme.onSurface,
                        ),
                        children: [
                          const TextSpan(
                            text: '"Discipline is not restriction. It is the only form of ',
                          ),
                          TextSpan(
                            text: 'freedom."',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  color: colorScheme.primary,
                                  blurRadius: 20,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    )
                        .animate()
                        .then(delay: 300.ms)
                        .fadeIn(duration: 2800.ms, curve: Curves.easeOutCubic)
                        .scale(
                          begin: Offset(0.9, 0.9),
                          end: Offset(1, 1),
                          duration: 1100.ms,
                          curve: Curves.easeOutBack,
                        )
                        .move(begin: Offset(0, 30), end: Offset.zero),

                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
              child: Column(
                children: [

                  const Text(
                    "Are you ready to take your freedom?",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                    textAlign: TextAlign.center,
                  )
                      .animate()
                      .then(delay: 400.ms)
                      .fadeIn(duration: 2800.ms, curve: Curves.easeOutCubic)
                      .scale(
                        begin: Offset(0.9, 0.9),
                        end: Offset(1, 1),
                        duration: 1100.ms,
                        curve: Curves.easeOutBack,
                      )
                      .move(begin: Offset(0, 30), end: Offset.zero),

                  const SizedBox(height: 20),

                  AnimatedTextButton(
                    text: "Yes, I'm ready",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => OnboardingScreen2()),
                    ),
                    fontSize: 19,
                    width: 300,
                    height: 60,
                    isGlowing: true,
                  )
                      .animate()
                      .then(delay: 500.ms)
                      .fadeIn(duration: 2800.ms, curve: Curves.easeOutCubic)
                      .scale(
                        begin: Offset(0.8, 0.8),
                        end: Offset(1, 1),
                        duration: 1100.ms,
                        curve: Curves.easeOutBack,
                      )
                      .move(begin: Offset(0, 30), end: Offset.zero),

                  const SizedBox(height: 16),

                  AnimatedTextButton(
                    text: "I want to stay a slave",
                    onTap: () => SystemNavigator.pop(),
                    fontSize: 17,
                    width: 300,
                    height: 50,
                    color: colorScheme.surfaceContainerHighest,
                    textColor: colorScheme.onSurfaceVariant,
                  )
                      .animate()
                      .then(delay: 500.ms)
                      .fadeIn(duration: 2800.ms, curve: Curves.easeOutCubic)
                      .scale(
                        begin: Offset(0.6, 0.6),
                        end: Offset(1, 1),
                        duration: 1300.ms,
                        curve: Curves.easeOutBack,
                      )
                      .move(begin: Offset(0, 30), end: Offset.zero),
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }

}
