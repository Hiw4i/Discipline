import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AnimatedIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isSelected;

  const AnimatedIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    required this.isSelected,
    });

  @override
  State<AnimatedIconButton> createState() => _AnimatedIconButtonState();
}

class _AnimatedIconButtonState extends State<AnimatedIconButton> {
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
        _scale = 1.1;
        _isHovered = true;
      }),
      onExit: (_) => setState(() {
        _scale = 1.0;
        _isHovered = false;
      }),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _scale = 0.9),
        onTapUp: (_) => setState(() => _scale = _isHovered ? 1.1 : 1.0),
        onTap: () {
          HapticFeedback.lightImpact();
          widget.onTap();
        },
        onTapCancel: () => setState(() => _scale = 1.0),
        child: AnimatedScale(
          scale: _scale,
          duration: const Duration(milliseconds: 600),
          curve: Curves.elasticOut,
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