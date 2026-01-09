import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../utils/platform_utils.dart';
import 'liquid_glass.dart';

/// Adaptive AppBar that uses CupertinoNavigationBar on iOS and Material AppBar on Android
class AdaptiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final Future<bool> Function()? onBackPressed;

  const AdaptiveAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return _buildCupertinoAppBar(context);
    }
    return _buildMaterialAppBar(context);
  }

  Widget _buildCupertinoAppBar(BuildContext context) {
    return FutureBuilder<bool>(
      future: PlatformUtils.supportsLiquidGlass(),
      builder: (context, snapshot) {
        final supportsGlass = snapshot.data ?? false;
        
        return LiquidGlass(
          opacity: supportsGlass ? 0.8 : 0.95,
          borderRadius: BorderRadius.zero,
          child: CupertinoNavigationBar(
            middle: title != null ? Text(title!) : null,
            leading: leading,
            trailing: actions != null && actions!.isNotEmpty
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: actions!,
                  )
                : null,
            automaticallyImplyLeading: automaticallyImplyLeading,
            backgroundColor: Colors.transparent,
            border: null,
          ),
        );
      },
    );
  }

  Widget _buildMaterialAppBar(BuildContext context) {
    return AppBar(
      title: title != null ? Text(title!) : null,
      leading: leading,
      actions: actions,
      automaticallyImplyLeading: automaticallyImplyLeading,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

