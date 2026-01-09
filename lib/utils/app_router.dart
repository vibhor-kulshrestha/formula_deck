import 'dart:io';
import 'package:go_router/go_router.dart';
import '../screens/home_screen.dart';
import '../screens/formula_detail_screen.dart';
import '../screens/ios_formula_detail_screen.dart';
import '../screens/bookmarks_screen.dart';
import '../screens/ios_bookmarks_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/ios_settings_screen.dart';

/// App router configuration using GoRouter
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/formula/:id',
      name: 'formula-detail',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        // Use iOS-optimized screen on iOS
        if (Platform.isIOS) {
          return IOSFormulaDetailScreen(formulaId: id);
        }
        return FormulaDetailScreen(formulaId: id);
      },
    ),
    GoRoute(
      path: '/bookmarks',
      name: 'bookmarks',
      builder: (context, state) {
        if (Platform.isIOS) {
          return const IOSBookmarksScreen();
        }
        return const BookmarksScreen();
      },
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) {
        if (Platform.isIOS) {
          return const IOSSettingsScreen();
        }
        return const SettingsScreen();
      },
    ),
  ],
  // Ensure proper back button handling
  errorBuilder: (context, state) => const HomeScreen(),
);

