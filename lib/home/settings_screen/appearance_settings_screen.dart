import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ascend/home/settings_screen/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';

class AppearanceSettingsScreen extends StatefulWidget {
  const AppearanceSettingsScreen({super.key});

  @override
  State<AppearanceSettingsScreen> createState() => _AppearanceSettingsScreenState();
}

class _AppearanceSettingsScreenState extends State<AppearanceSettingsScreen> {

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(

      body: Container(
        decoration: BoxDecoration(color: colorScheme.surfaceContainer),
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            AppearanceModeSection(
              selectedMode: settings.themeMode,
              onModeChanged: settings.setThemeMode,
            ),
            SizedBox(height: 20),
            ThemeColorSection(
              selectedColor: settings.themeColor,
              onColorChanged: settings.setThemeColor,
            ),
            SizedBox(height: 20),
            if (isDarkTheme)
              AmoledSection(
                amoled: settings.amoled,
                onToggle: settings.setAmoled,
              ),
          ],
        ),
      ),
    );
  }
}

class AppearanceModeSection extends StatelessWidget {
  final ThemeMode selectedMode;
  final ValueChanged<ThemeMode> onModeChanged;

  const AppearanceModeSection({super.key, required this.selectedMode, required this.onModeChanged});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
            children: [
              Expanded(
                child: _ModeButton(
                  mode: ThemeMode.light,
                  icon: Icons.wb_sunny,
                  label: 'Light',
                  isSelected: selectedMode == ThemeMode.light,
                  onTap: () => onModeChanged(ThemeMode.light),
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: _ModeButton(
                  mode: ThemeMode.dark,
                  icon: Icons.nightlight_round,
                  label: 'Dark',
                  isSelected: selectedMode == ThemeMode.dark,
                  onTap: () => onModeChanged(ThemeMode.dark),
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: _ModeButton(
                  mode: ThemeMode.system,
                  icon: Icons.settings,
                  label: 'System',
                  isSelected: selectedMode == ThemeMode.system,
                  onTap: () => onModeChanged(ThemeMode.system),
                ),
              ),
            ],
          ),
        
    );
  }
}

class _ModeButton extends StatefulWidget {
  final ThemeMode mode;
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ModeButton({
    required this.mode,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_ModeButton> createState() => _ModeButtonState();
}

class _ModeButtonState extends State<_ModeButton> {
  double _scale = 1.0;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return MouseRegion(
      onEnter: (_) => setState(() {
        _scale = 1.05;   // Increase size on hover
        _isHovered = true;
      }),
      onExit: (_) => setState(() {
        _scale = 1.0;   // Return to normal size when cursor leaves
        _isHovered = false;
      }),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _scale = 0.95),    // Decrease size when pressed
        onTapUp: (_) => setState(() => _scale = widget.isSelected ? 1.05 : 1.0), // Return to normal size after press
         onTapCancel: () => setState(() => _scale = 1.0),   // Return to normal size if press is canceled
        onTap: () {
            HapticFeedback.lightImpact();
            widget.onTap();
          },
        child: AnimatedScale(
          scale: _scale * (widget.isSelected ? 1.05 : 1.0),   // Selected element will be slightly larger than others
          duration: const Duration(milliseconds: 600),
          curve: Curves.elasticOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: widget.isSelected ? colorScheme.primaryContainer : colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(24),
              boxShadow: widget.isSelected
              ? [
                BoxShadow(
                  color: colorScheme.primaryContainer.withValues(alpha: 0.5),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ]
              : [],
            ),
            child: Column(
              children: [
                Icon(
                  widget.icon,
                  color: widget.isSelected ? colorScheme.onPrimaryContainer : colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                  size: 24,
                ),
                SizedBox(height: 8),
                Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 14,
                    color: widget.isSelected ? colorScheme.onPrimaryContainer : colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ThemeColorSection extends StatefulWidget {
  final String selectedColor;
  final ValueChanged<String> onColorChanged;

  const ThemeColorSection({super.key, required this.selectedColor, required this.onColorChanged});

  @override
  State<ThemeColorSection> createState() => _ThemeColorSectionState();
}

class _ThemeColorSectionState extends State<ThemeColorSection> {
  final _scrollController = ScrollController();

  final List<Map<String, dynamic>> colors = [
    {'name': 'Dynamic', 'color': Color(0xFFB76A6A)},
    {'name': 'Ocean',   'color': Color.fromARGB(255, 45,  117, 117)},
    {'name': 'Purple',  'color': Color.fromARGB(255, 122, 70,  143)},
    {'name': 'Forest',  'color': Color.fromARGB(255, 14,  71,  54)},
    {'name': 'Amber',   'color': Color.fromARGB(255, 192, 116, 30)},
    {'name': 'Sunset',  'color': Color.fromARGB(255, 194, 94,  94)},
    {'name': 'Sky',     'color': Color.fromARGB(255, 70,  130, 180)},
    {'name': 'Mint',    'color': Color.fromARGB(255, 152, 255, 152)},
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 4),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              'Theme Color',
              style: TextStyle(
                fontSize: 16,
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          FadingEdgeScrollView.fromSingleChildScrollView(
            gradientFractionOnStart: 0.1,
            gradientFractionOnEnd: 0.1,    
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 12),
              
              child: Row(
                children: colors.map((colorData) {
                  final isSelected = widget.selectedColor == colorData['name'].toLowerCase();

                  return Padding(
                    padding: EdgeInsets.only(right: 12, top: 24, bottom: 16),
                    child: _ColorButton(
                      color: colorData['color'],
                      name: colorData['name'],
                      isSelected: isSelected,
                      onTap: () => widget.onColorChanged(colorData['name'].toLowerCase()),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

        ],
      ),
    );
  }
}

class _ColorButton extends StatefulWidget {
  final Color color;
  final String name;
  final bool isSelected;
  final VoidCallback onTap;

  const _ColorButton({
    required this.color,
    required this.name,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_ColorButton> createState() => _ColorButtonState();
}

class _ColorButtonState extends State<_ColorButton> {
  double _scale = 1.0;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    

    return MouseRegion(
      onEnter: (_) => setState(() {
        _scale = 1.1; // Increase size on hover
        _isHovered = true;
      }),
      onExit: (_) => setState(() {
        _scale = 1;   // Return to normal size when cursor leaves
        _isHovered = false;
      }),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _scale = 0.95),  // Decrease size when pressed
        onTapUp: (_) => setState(() => _scale = widget.isSelected ? 1.1 : 1.0), // Return to normal size after press
        onTapCancel: () => setState(() => _scale = 1.0), // Return to normal size if press is canceled
        onTap: () {
          HapticFeedback.lightImpact();
          widget.onTap();
        },
        child: AnimatedScale(
          scale: _scale * (widget.isSelected ? 1.1 : 1.0),    // Selected element will be slightly larger than others
          duration: const Duration(milliseconds: 600),
          curve: Curves.elasticOut,
          child: Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: widget.color,
                  shape: BoxShape.circle,
                  boxShadow: widget.isSelected
                      ? [
                          BoxShadow(
                            color: widget.color.withValues(alpha: 0.6),
                            blurRadius: 14,
                            spreadRadius: 2,
                          ),
                        ]
                      : [],
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: (child, animation) =>
                      ScaleTransition(scale: animation, child: child),
                  child: widget.isSelected
                      ? Icon(
                          Icons.check,
                          key: const ValueKey('check'),
                          color: colorScheme.onPrimaryContainer,
                          size: 24,
                        )
                      : const SizedBox(key: ValueKey('empty')),
                ),
              ),
              const SizedBox(height: 8),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  fontFamily: 'JetBrains Mono',
                  fontSize: 12,
                  color: widget.isSelected
                      ? widget.color
                      : const Color(0xFFA0A0A0),
                  fontWeight: FontWeight.w500,
                ),
                child: Text(widget.name),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AmoledSection extends StatelessWidget {
  final bool amoled;
  final ValueChanged<bool> onToggle;

  const AmoledSection({super.key, required this.amoled, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AMOLED Black Theme',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Pure black background for dark mode',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFFA0A0A0),
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: amoled,
            onChanged: onToggle,
            
            activeThumbColor: colorScheme.primaryContainer,
            activeTrackColor: colorScheme.primary,

            inactiveThumbColor: colorScheme.onSurfaceVariant, 
            inactiveTrackColor: colorScheme.surfaceContainerHighest,

            trackOutlineColor: WidgetStateProperty.fromMap({
                WidgetState.selected: colorScheme.primary,
                WidgetState.disabled: colorScheme.onSurfaceVariant,
            }),
          ),
        ],
      ),
    );
  }
}