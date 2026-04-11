import 'package:flutter/material.dart';
import 'package:ascend/components/animated_text_button.dart';
import 'package:ascend/on_boarding/1.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Stack(
        children: [

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                AnimatedTextButton(
                  text: "Onboarding",
                  onTap:() => Navigator.push(context, MaterialPageRoute(builder: (_) => OnboardingScreen1())),
                  fontSize: 19,
                  width: 260,
                  height: 60,
                ),

              ],
            )
          ) 
          
        ]
      ) 
    );
  }
}
