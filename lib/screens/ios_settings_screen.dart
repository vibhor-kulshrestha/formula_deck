import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/formula_provider.dart';
import '../services/auth_service.dart';
import '../services/hive_service.dart';
import '../services/iap_service.dart';
import '../widgets/liquid_glass.dart';

/// iOS-optimized settings screen with Cupertino design
class IOSSettingsScreen extends ConsumerStatefulWidget {
  const IOSSettingsScreen({super.key});

  @override
  ConsumerState<IOSSettingsScreen> createState() => _IOSSettingsScreenState();
}

class _IOSSettingsScreenState extends ConsumerState<IOSSettingsScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final darkMode = ref.watch(darkModeProvider);
    final adsRemoved = ref.watch(adsRemovedProvider);
    final isSignedIn = AuthService.isSignedIn;
    final currentUser = AuthService.currentUser;

    if (!Platform.isIOS) {
      return const SizedBox.shrink();
    }

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Settings',
          style: TextStyle(
            inherit: false,
            fontFamily: '.SF Pro Display',
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: CupertinoColors.label,
          ),
        ),
        backgroundColor: CupertinoColors.systemGroupedBackground.withValues(alpha: 0.8),
        border: null,
      ),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Account section
            SliverToBoxAdapter(
              child: LiquidGlassContainer(
                padding: EdgeInsets.zero,
                borderRadius: BorderRadius.circular(12),
                child: CupertinoListSection(
                  children: [
                    CupertinoListTile(
                      leading: const Icon(CupertinoIcons.person_circle),
                      title: const Text('Account'),
                      subtitle: Text(
                        isSignedIn
                            ? (currentUser?.email ?? 'Signed in')
                            : 'Not signed in',
                        style: const TextStyle(
                          fontFamily: '.SF Pro Text',
                          fontSize: 14,
                          color: CupertinoColors.secondaryLabel,
                        ),
                      ),
                      trailing: isSignedIn
                          ? CupertinoButton(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              onPressed: _signOut,
                              child: const Text(
                                'Sign Out',
                                style: TextStyle(
                                  color: CupertinoColors.systemBlue,
                                  fontFamily: '.SF Pro Text',
                                ),
                              ),
                            )
                          : CupertinoButton(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              onPressed: _signIn,
                              child: const Text(
                                'Sign In',
                                style: TextStyle(
                                  color: CupertinoColors.systemBlue,
                                  fontFamily: '.SF Pro Text',
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            // Appearance section
            SliverToBoxAdapter(
              child: LiquidGlassContainer(
                padding: EdgeInsets.zero,
                borderRadius: BorderRadius.circular(12),
                child: CupertinoListSection(
                  header: const Text(
                    'Appearance',
                    style: TextStyle(
                      fontFamily: '.SF Pro Text',
                      fontSize: 13,
                      color: CupertinoColors.secondaryLabel,
                    ),
                  ),
                  children: [
                    CupertinoListTile(
                      leading: const Icon(CupertinoIcons.moon),
                      title: const Text('Dark Mode'),
                      subtitle: Text(
                        adsRemoved
                            ? 'Enabled'
                            : 'Available after purchasing Remove Ads',
                        style: const TextStyle(
                          fontFamily: '.SF Pro Text',
                          fontSize: 14,
                          color: CupertinoColors.secondaryLabel,
                        ),
                      ),
                      trailing: CupertinoSwitch(
                        value: darkMode && adsRemoved,
                        onChanged: adsRemoved
                            ? (value) {
                                HiveService.setDarkMode(value);
                                ref.read(darkModeProvider.notifier).state = value;
                              }
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            // Remove Ads section
            if (!adsRemoved)
              SliverToBoxAdapter(
                child: LiquidGlassContainer(
                  padding: EdgeInsets.zero,
                  borderRadius: BorderRadius.circular(12),
                  child: CupertinoListSection(
                    header: const Text(
                      'Premium',
                      style: TextStyle(
                        fontFamily: '.SF Pro Text',
                        fontSize: 13,
                        color: CupertinoColors.secondaryLabel,
                      ),
                    ),
                    children: [
                      CupertinoListTile(
                        leading: const Icon(CupertinoIcons.star),
                        title: const Text('Remove Ads + Dark Mode'),
                        subtitle: const Text(
                          'Unlock dark mode and remove all ads',
                          style: TextStyle(
                            fontFamily: '.SF Pro Text',
                            fontSize: 14,
                            color: CupertinoColors.secondaryLabel,
                          ),
                        ),
                        trailing: _isLoading
                            ? const CupertinoActivityIndicator()
                            : CupertinoButton(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                onPressed: _purchaseRemoveAds,
                                child: const Text(
                                  'Purchase',
                                  style: TextStyle(
                                    color: CupertinoColors.systemBlue,
                                    fontFamily: '.SF Pro Text',
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              )
            else
              SliverToBoxAdapter(
                child: LiquidGlassContainer(
                  padding: EdgeInsets.zero,
                  borderRadius: BorderRadius.circular(12),
                  child: CupertinoListSection(
                    children: [
                      CupertinoListTile(
                        leading: const Icon(
                          CupertinoIcons.check_mark_circled_solid,
                          color: CupertinoColors.systemGreen,
                        ),
                        title: const Text('Premium Features'),
                        subtitle: const Text(
                          'Ads removed and dark mode enabled',
                          style: TextStyle(
                            fontFamily: '.SF Pro Text',
                            fontSize: 14,
                            color: CupertinoColors.secondaryLabel,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            // About section
            SliverToBoxAdapter(
              child: LiquidGlassContainer(
                padding: EdgeInsets.zero,
                borderRadius: BorderRadius.circular(12),
                child: CupertinoListSection(
                  header: const Text(
                    'About',
                    style: TextStyle(
                      fontFamily: '.SF Pro Text',
                      fontSize: 13,
                      color: CupertinoColors.secondaryLabel,
                    ),
                  ),
                  children: [
                    const CupertinoListTile(
                      leading: Icon(CupertinoIcons.info),
                      title: Text('About'),
                      subtitle: Text(
                        'FormulaDeck v1.0.0\nThe Lazy Student\'s Vault',
                        style: TextStyle(
                          fontFamily: '.SF Pro Text',
                          fontSize: 14,
                          color: CupertinoColors.secondaryLabel,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signIn() async {
    setState(() => _isLoading = true);
    try {
      await AuthService.signInWithGoogle();
      if (mounted) {
        showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: const Text('Success'),
            content: const Text('Signed in successfully'),
            actions: [
              CupertinoDialogAction(
                child: const Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: const Text('Error'),
            content: Text('Sign in failed: $e'),
            actions: [
              CupertinoDialogAction(
                child: const Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _signOut() async {
    await AuthService.signOut();
    if (mounted) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Signed Out'),
          content: const Text('You have been signed out'),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _purchaseRemoveAds() async {
    setState(() => _isLoading = true);
    try {
      final success = await IAPService.buyRemoveAds();
      if (success) {
        if (mounted) {
          showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: const Text('Purchase Initiated'),
              content: const Text('Your purchase is being processed'),
              actions: [
                CupertinoDialogAction(
                  child: const Text('OK'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          );
        }
      } else {
        if (mounted) {
          showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: const Text('Purchase Failed'),
              content: const Text('Unable to initiate purchase'),
              actions: [
                CupertinoDialogAction(
                  child: const Text('OK'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: const Text('Error'),
            content: Text('Error: $e'),
            actions: [
              CupertinoDialogAction(
                child: const Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}

