import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

void _defaultOnTap() {
  print('Tile tapped, but no action defined');
}

Widget _defaultScreen(BuildContext context) {
  final ColorScheme colorScheme = Theme.of(context).colorScheme;

  return Scaffold(
    appBar: AppBar(
      title: const Text("Default Screen"),
      backgroundColor: colorScheme.surfaceContainer,
      ),
    body: const Center(child: Text("This is a placeholder screen.")),
    backgroundColor: colorScheme.surfaceContainer,
  );
}

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isFirst;
  final bool isLast;
  final bool isSelected;
  final bool isDesktop;
  final VoidCallback? onTap;
  final Widget? destination;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.isFirst = false,
    this.isLast = false,
    this.isSelected = false,
    this.isDesktop = false,
    this.onTap,
    this.destination,
  });



  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    BorderRadius getBorderRadius() {
      if (isDesktop && isSelected) {
        return BorderRadius.circular(24);
      } else {
        return BorderRadius.vertical(
          top: isFirst ? Radius.circular(24) : Radius.circular(6),
          bottom: isLast ? Radius.circular(24) : Radius.circular(6),
        );
      }
    }
    
    Color getTileColor() {
      if (isSelected && isDesktop) {
        return colorScheme.surfaceContainerHighest;
      } else {
        return colorScheme.surfaceContainer;
      }
    }

    
    return Padding(

      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      child: isDesktop
        ? AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              color: getTileColor(),
              borderRadius: getBorderRadius(),
            ),
            child: ListTile(
              shape: RoundedRectangleBorder(borderRadius: getBorderRadius()),
              leading: Icon(icon, color: colorScheme.onSurfaceVariant),
              title: Text(title, style: TextStyle(color: colorScheme.onSurface)),
              onTap: onTap ?? _defaultOnTap,
            ),
          )
        : OpenContainer(
            transitionType: ContainerTransitionType.fadeThrough,
            openBuilder: (context, _) => destination ?? _defaultScreen(context),
            closedElevation: 0,
            closedShape: RoundedRectangleBorder(borderRadius: getBorderRadius()),
            openColor: colorScheme.surfaceContainer,
            closedColor: getTileColor(),
            middleColor: colorScheme.surfaceContainer,
            closedBuilder: (context, openContainer) => ListTile(
              leading: Icon(icon, color: colorScheme.onSurfaceVariant),
              title: Text(title, style: TextStyle(color: colorScheme.onSurface)),
              onTap: openContainer,
            ),
          ),
    
    );

  }

}