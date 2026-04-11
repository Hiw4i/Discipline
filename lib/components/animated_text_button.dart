import 'package:flutter/material.dart';

class AnimatedTextButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final double? fontSize;
  final double? width;
  final double? height;
  final Color? color;
  final Color? textColor;
  final bool isGlowing;

  const AnimatedTextButton({
    super.key,
    required this.text,
    required this.onTap,
    this.fontSize,
    this.width,
    this.height,
    this.color,
    this.textColor,
    this.isGlowing = false,
  });

  @override
  State<AnimatedTextButton> createState() => _AnimatedTextButtonState();
}

class _AnimatedTextButtonState extends State<AnimatedTextButton> {
  double _scale = 1.0;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    Color glowColor = widget.color ?? colorScheme.primaryContainer;

    return MouseRegion(
      onEnter: (_) => setState(() {
        _scale = 1.05;
        _isHovered = true;
      }),
      onExit: (_) => setState(() {
        _scale = 1.0;
        _isHovered = false;
      }),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _scale = 0.95),
        onTapUp: (_) => setState(() => _scale = _isHovered ? 1.05 : 1.0),
        onTap: widget.onTap,
        onTapCancel: () => setState(() => _scale = 1.0),
        child: AnimatedScale(
          scale: _scale,
          duration: const Duration(milliseconds: 600),
          curve: Curves.elasticOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(10),
            width: widget.width ?? 200,
            height: widget.height ?? 50,
            decoration: BoxDecoration(
              color: widget.color ?? colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(32),
              boxShadow: widget.isGlowing
                  ? [
                      BoxShadow(
                        color: glowColor.withAlpha(_isHovered ? 230 : 153),
                        blurRadius: 30,
                        spreadRadius: 2,
                      ),
                    ]
                  : [],
            ),
            child: Center(
              child: Text(
                widget.text,
                style: TextStyle(
                  color: widget.textColor ?? colorScheme.onPrimaryContainer,
                  fontSize: widget.fontSize ?? 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          )
        ),
      ),
    );
  }
}