import 'package:flutter/material.dart';
import 'package:ascend/components/animated_text_button.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:ascend/main.dart';

class OnboardingScreen3 extends StatefulWidget {
  const OnboardingScreen3({super.key});

  @override
  State<OnboardingScreen3> createState() => _OnboardingScreen3State();
}

class _OnboardingScreen3State extends State<OnboardingScreen3> {

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [

            Expanded(
              child: Center(

                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontFamily: 'JetBrainsMono',
                      fontSize: 22,
                      color: colorScheme.onSurface,
                    ),
                    children: [
                      const TextSpan(text: 'Onboarding: '),
                      TextSpan(
                        text: '3',
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
                    .fadeIn(duration: 800.ms, curve: Curves.easeOut)
                    .scale(
                      begin: const Offset(0.9, 0.9),
                      end: const Offset(1, 1),
                      duration: 600.ms,
                    )
                    .move(begin: const Offset(0, 30), end: Offset.zero),
                    
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
              child: AnimatedTextButton(
                text: "Get Started",
                onTap:() => Navigator.push(context, MaterialPageRoute(builder: (_) => MyHomePage())),
                fontSize: 19,
                width: 300,
                height: 60,
                isGlowing: true,
              ).animate()
                .then(delay: 500.ms)
                .fadeIn(duration: 2800.ms, curve: Curves.easeOutCubic)
                .scale(begin: Offset(0.6, 0.6), end: Offset(1, 1), duration: 1300.ms, curve: Curves.easeOutBack)
                .move(begin: Offset(0, 30), end: Offset.zero),
            ),
          ],
        ),
      ),
    );
  }

}
