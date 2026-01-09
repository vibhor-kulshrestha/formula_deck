import 'dart:io';
import 'package:flutter/cupertino.dart';
import '../utils/platform_utils.dart';
import 'ipad_sidebar.dart';

/// iPad-optimized scaffold with sidebar
class IPadScaffold extends StatelessWidget {
  final Widget body;

  const IPadScaffold({
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    if (!Platform.isIOS) {
      return body;
    }

    return FutureBuilder<bool>(
      future: PlatformUtils.isIPad,
      builder: (context, snapshot) {
        final isIPad = snapshot.data ?? false;

        if (!isIPad) {
          return body;
        }

        // iPad layout with sidebar
        return Row(
          children: [
            // Sidebar (fixed width)
            SizedBox(
              width: 280,
              child: IPadSidebar(),
            ),
            // Divider
            Container(
              width: 0.5,
              color: CupertinoColors.separator,
            ),
            // Main content
            Expanded(
              child: body,
            ),
          ],
        );
      },
    );
  }
}

