import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'utils/app_theme.dart';
import 'utils/app_router.dart';
import 'services/hive_service.dart';
import 'services/ads_service.dart';
import 'services/iap_service.dart';
import 'providers/formula_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase (optional - app works without it)
  try {
    await Firebase.initializeApp();
  } catch (e) {
    // Firebase not configured - app will work in offline mode
    debugPrint('Firebase initialization skipped: $e');
  }
  
  // Initialize Hive
  await HiveService.init();
  
  // Initialize AdMob
  await AdsService.init();
  
  // Initialize IAP
  await IAPService.init();
  
  // Listen to IAP purchase updates
  IAPService.purchaseUpdated.listen((purchases) {
    // Handle purchases (already handled in IAPService)
  });
  
  runApp(
    const ProviderScope(
      child: FormulaDeckApp(),
    ),
  );
}

class FormulaDeckApp extends ConsumerWidget {
  const FormulaDeckApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkMode = ref.watch(darkModeProvider);

    return MaterialApp.router(
      title: 'FormulaDeck',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
      routerConfig: appRouter,
    );
  }
}
