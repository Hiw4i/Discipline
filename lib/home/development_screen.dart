import 'package:flutter/material.dart';

class DevelopmentScreen extends StatefulWidget {
  const DevelopmentScreen({super.key});

  @override
  State<DevelopmentScreen> createState() => _DevelopmentScreenState();
}

class _DevelopmentScreenState extends State<DevelopmentScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: const Text("Development Screen")
      ),
    );
  }
}
