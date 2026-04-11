import 'package:flutter/material.dart';
import 'home/home_screen.dart';
import 'home/statistics_screen.dart';
import 'home/settings_screen/settings_screen.dart';
import 'home/development_screen.dart';
import 'package:ascend/components/glass_nav_bar.dart';
import 'package:provider/provider.dart';
import 'home/settings_screen/settings_provider.dart';
import 'package:dynamic_color/dynamic_color.dart';

void main() async {
  // To read memory before runApp, because I need to load settings from SharedPreferences before the app starts.
  WidgetsFlutterBinding.ensureInitialized();
  
  final settingsProvider = SettingsProvider();
  await settingsProvider.loadSettings();    // Wait for settings to load from SharedPreferences

  runApp(
    ChangeNotifierProvider.value(
      value: settingsProvider,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();

    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {

        return MaterialApp(
          title: 'Discipline',
          debugShowCheckedModeBanner: false,
          themeMode: settings.themeMode,
          
          // Light Theme
          theme: ThemeData(
            colorScheme: (settings.themeColor == 'dynamic' && lightDynamic != null)
              ? lightDynamic.copyWith( // Fix bug: in "dynamic" surfaceContainer =  surfaceContainerHighest = surface, although they should be different.
                  surfaceContainer: Color.alphaBlend(Colors.white.withValues(alpha: 0.6), lightDynamic.secondaryContainer),
                  surfaceContainerHighest:  Color.alphaBlend(Colors.white.withValues(alpha: 0.5), lightDynamic.outlineVariant),
                  )
              : ColorScheme.fromSeed(seedColor: settings.currentSeedColor, brightness: Brightness.light),
            useMaterial3: true,
            fontFamily: 'JetBrainsMono',
          ),

          // Dark Theme
          darkTheme: ThemeData(
            colorScheme: (settings.themeColor == 'dynamic' && darkDynamic != null)
                ? darkDynamic.copyWith( // Fix bug: in "dynamic" surfaceContainer =  surfaceContainerHighest = surface, although they should be different.
                  surfaceContainer: Color.alphaBlend(const Color.fromARGB(255, 14, 14, 14).withValues(alpha: 0.6), darkDynamic.secondaryContainer),
                  surfaceContainerHighest:  Color.alphaBlend(Colors.black.withValues(alpha: 0.3), darkDynamic.outlineVariant),
                  )
                : ColorScheme.fromSeed(seedColor: settings.currentSeedColor, brightness: Brightness.dark),
            scaffoldBackgroundColor: settings.amoled ? Colors.black : null,
            useMaterial3: true,
            fontFamily: 'JetBrainsMono',
          ),

          // IOS Bouncing Scroll Physics
          builder: (context, child) {
            return ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(
                physics: const BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.fast),
              ),
              child: child!,
            );
          },

          home: const MyHomePage(),
        );
      }
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
