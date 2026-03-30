import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isSelected;

  const AnimatedButton({
    super.key,
    required this.icon,
    required this.onTap,
    required this.isSelected,
    });

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  double _scale = 1.0;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    Color backgroundColor = Colors.transparent;
    if (widget.isSelected) {
      backgroundColor = colorScheme.primaryContainer; 
    } else if (_isHovered) {
      backgroundColor = colorScheme.onSurface.withValues(alpha: 0.1);
    }

    return MouseRegion(
      onEnter: (_) => setState(() {
        _scale = 1.2;
        _isHovered = true;
      }),
      onExit: (_) => setState(() {
        _scale = 1.0;
        _isHovered = false;
      }),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _scale = 0.9),
        onTapUp: (_) => setState(() => _scale = 1.2),
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _scale,
          duration: const Duration(milliseconds: 300),
          curve: Curves.bounceInOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              widget.icon, 
              color: widget.isSelected
                ? colorScheme.onPrimaryContainer
                : colorScheme.onSurfaceVariant
              ),
          )
        ),
      ),
    );
  }
}