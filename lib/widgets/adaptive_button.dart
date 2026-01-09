import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// Adaptive button that uses CupertinoButton on iOS
class AdaptiveButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final double? minSize;

  const AdaptiveButton({
    super.key,
    required this.child,
    this.onPressed,
    this.color,
    this.padding,
    this.minSize,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoButton(
        onPressed: onPressed,
        color: color,
        padding: padding,
        minimumSize: minSize != null ? Size(minSize!, minSize!) : null,
        child: child,
      );
    }

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: padding,
        minimumSize: minSize != null ? Size(minSize!, minSize!) : null,
      ),
      child: child,
    );
  }
}

