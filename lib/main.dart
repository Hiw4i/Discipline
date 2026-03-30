import 'package:flutter/material.dart';
import 'home/home_screen.dart';
import 'home/statistics_screen.dart';
import 'home/settings_screen.dart';
import 'home/development_screen.dart';
import 'package:disciplite/components/glass_nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Discipline',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 117, 78, 20),
          brightness: Brightness.dark,
        ),
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {

  int _selectedIndex = 0;
  final screens = [
    HomeScreen(),
    DevelopmentScreen(),
    StatisticsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isDesktop = width > 800;

    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            IndexedStack(
              index: _selectedIndex,
              children: screens,
            ),

            Align(
              alignment: isDesktop
                ? Alignment.bottomRight
                : Alignment.bottomCenter,
              child: GlassNavBar(
                onHomeTap: () => setState(() => _selectedIndex = 0), 
                onDevelopmentTap: () => setState(() => _selectedIndex = 1),
                onStatisticsTap: () => setState(() => _selectedIndex = 2),
                onSettingsTap: () => setState(() => _selectedIndex = 3),
                currentIndex: _selectedIndex,
              ),
            ),
          ]
        )
      ),

    );
  }
}
