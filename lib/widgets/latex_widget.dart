import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

/// Widget for rendering LaTeX formulas
class LaTeXWidget extends StatelessWidget {
  final String latex;
  final double? fontSize;
  final Color? color;

  const LaTeXWidget({
    super.key,
    required this.latex,
    this.fontSize,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    try {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Math.tex(
          latex,
          mathStyle: MathStyle.text,
          textStyle: TextStyle(
            fontSize: fontSize ?? 16,
            color: color ?? Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
      );
    } catch (e) {
      // Fallback to text if LaTeX parsing fails
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Text(
          latex,
          style: TextStyle(
            fontSize: fontSize ?? 16,
            color: color ?? Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
      );
    }
  }
}

