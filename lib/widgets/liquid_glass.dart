import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import '../utils/platform_utils.dart';

/// Liquid Glass (glassmorphism) widget for iOS
class LiquidGlass extends StatelessWidget {
  final Widget child;
  final double? opacity;
  final Color? tintColor;
  final BorderRadius? borderRadius;

  const LiquidGlass({
    super.key,
    required this.child,
    this.opacity,
    this.tintColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    if (!Platform.isIOS) {
      return child;
    }

    return FutureBuilder<bool>(
      future: PlatformUtils.supportsLiquidGlass(),
      builder: (context, snapshot) {
        final supportsGlass = snapshot.data ?? false;

        if (!supportsGlass) {
          // Fallback for older iOS versions
          return Container(
            decoration: BoxDecoration(
              color: CupertinoTheme.of(context).barBackgroundColor.withValues(alpha: 0.7),
              borderRadius: borderRadius ?? BorderRadius.circular(12),
            ),
            child: child,
          );
        }

        // Liquid Glass effect for iOS 15+
        return ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.circular(12),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              decoration: BoxDecoration(
                color: (tintColor ??
                        CupertinoTheme.of(context).barBackgroundColor)
                    .withValues(alpha: opacity ?? 0.7),
                borderRadius: borderRadius ?? BorderRadius.circular(12),
                border: Border.all(
                  color: CupertinoColors.white.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: child,
            ),
          ),
        );
      },
    );
  }
}

/// Liquid Glass container with padding
class LiquidGlassContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? opacity;
  final Color? tintColor;
  final BorderRadius? borderRadius;

  const LiquidGlassContainer({
    super.key,
    required this.child,
    this.padding,
    this.opacity,
    this.tintColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return LiquidGlass(
      opacity: opacity,
      tintColor: tintColor,
      borderRadius: borderRadius,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}

