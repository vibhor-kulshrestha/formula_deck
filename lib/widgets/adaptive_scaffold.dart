import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'adaptive_app_bar.dart';

/// Adaptive Scaffold that uses CupertinoPageScaffold on iOS
class AdaptiveScaffold extends StatelessWidget {
  final AdaptiveAppBar? appBar;
  final Widget body;
  final Widget? floatingActionButton;
  final Color? backgroundColor;
  final bool resizeToAvoidBottomInset;

  const AdaptiveScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.floatingActionButton,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        navigationBar: appBar != null
            ? CupertinoNavigationBar(
                middle: appBar!.title != null ? Text(appBar!.title!) : null,
                leading: appBar!.leading,
                trailing: appBar!.actions != null && appBar!.actions!.isNotEmpty
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: appBar!.actions!,
                      )
                    : null,
                automaticallyImplyLeading: appBar!.automaticallyImplyLeading,
                backgroundColor: CupertinoColors.systemGroupedBackground.withValues(alpha: 0.8),
              )
            : null,
        child: SafeArea(
          child: body,
        ),
      );
    }

    return Scaffold(
      appBar: appBar,
      body: body,
      floatingActionButton: floatingActionButton,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }
}

