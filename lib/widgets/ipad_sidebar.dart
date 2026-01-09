import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../services/auth_service.dart';
import '../widgets/liquid_glass.dart';

/// iPad sidebar navigation
class IPadSidebar extends ConsumerWidget {
  const IPadSidebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!Platform.isIOS) {
      return const SizedBox.shrink();
    }

    // Safely get current route
    String currentRoute = '/';
    try {
      final routerState = GoRouterState.of(context);
      currentRoute = routerState.uri.path;
    } catch (e) {
      // Router not yet initialized, use default
      currentRoute = '/';
    }
    
    final isSignedIn = AuthService.isSignedIn;

    return LiquidGlassContainer(
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.zero,
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'FormulaDeck',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: '.SF Pro Display',
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  isSignedIn
                      ? (AuthService.currentUser?.email ?? 'Signed in')
                      : 'Not signed in',
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: '.SF Pro Text',
                    color: CupertinoColors.secondaryLabel,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Navigation items
          Expanded(
            child: ListView(
              children: [
                _SidebarItem(
                  icon: CupertinoIcons.home,
                  title: 'Home',
                  route: '/',
                  isSelected: currentRoute == '/',
                  onTap: () => context.push('/'),
                ),
                _SidebarItem(
                  icon: CupertinoIcons.bookmark,
                  title: 'Bookmarks',
                  route: '/bookmarks',
                  isSelected: currentRoute == '/bookmarks',
                  onTap: () => context.push('/bookmarks'),
                ),
                _SidebarItem(
                  icon: CupertinoIcons.settings,
                  title: 'Settings',
                  route: '/settings',
                  isSelected: currentRoute == '/settings',
                  onTap: () => context.push('/settings'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String route;
  final bool isSelected;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.icon,
    required this.title,
    required this.route,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            color: isSelected
                ? CupertinoColors.systemBlue.withValues(alpha: 0.1)
                : const Color(0x00000000),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? CupertinoColors.systemBlue
                  : CupertinoColors.secondaryLabel,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 17,
                fontFamily: '.SF Pro Text',
                color: isSelected
                    ? CupertinoColors.systemBlue
                    : CupertinoColors.label,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

