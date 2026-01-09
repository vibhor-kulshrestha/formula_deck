import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/formula_provider.dart';
import '../services/auth_service.dart';
import '../services/hive_service.dart';
import '../services/iap_service.dart';

/// Settings screen with dark mode toggle and IAP
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final darkMode = ref.watch(darkModeProvider);
    final adsRemoved = ref.watch(adsRemovedProvider);
    final isSignedIn = AuthService.isSignedIn;
    final currentUser = AuthService.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          // Account section
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Account'),
            subtitle: Text(
              isSignedIn
                  ? (currentUser?.email ?? 'Signed in')
                  : 'Not signed in',
            ),
            trailing: isSignedIn
                ? TextButton(
                    onPressed: _signOut,
                    child: const Text('Sign Out'),
                  )
                : TextButton(
                    onPressed: _signIn,
                    child: const Text('Sign In'),
                  ),
          ),
          const Divider(),
          // Appearance section
          SwitchListTile(
            secondary: const Icon(Icons.dark_mode),
            title: const Text('Dark Mode'),
            subtitle: Text(
              adsRemoved
                  ? 'Enabled'
                  : 'Available after purchasing Remove Ads',
            ),
            value: darkMode && adsRemoved,
            onChanged: adsRemoved
                ? (value) {
                    HiveService.setDarkMode(value);
                    ref.read(darkModeProvider.notifier).state = value;
                  }
                : null,
          ),
          const Divider(),
          // Remove Ads section
          if (!adsRemoved) ...[
            ListTile(
              leading: const Icon(Icons.remove_circle_outline),
              title: const Text('Remove Ads + Dark Mode'),
              subtitle: const Text('Unlock dark mode and remove all ads'),
              trailing: _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _purchaseRemoveAds,
                      child: const Text('Purchase'),
                    ),
            ),
            const Divider(),
          ] else ...[
            ListTile(
              leading: const Icon(Icons.check_circle, color: Colors.green),
              title: const Text('Premium Features'),
              subtitle: const Text('Ads removed and dark mode enabled'),
              trailing: const Icon(Icons.check, color: Colors.green),
            ),
            const Divider(),
          ],
          // About section
          const ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            subtitle: Text('FormulaDeck v1.0.0\nThe Lazy Student\'s Vault'),
          ),
        ],
      ),
    );
  }

  Future<void> _signIn() async {
    setState(() => _isLoading = true);
    try {
      await AuthService.signInWithGoogle();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signed in successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign in failed: $e')),
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Signed out')),
      );
    }
  }

  Future<void> _purchaseRemoveAds() async {
    setState(() => _isLoading = true);
    try {
      final success = await IAPService.buyRemoveAds();
      if (success) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Purchase initiated')),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Purchase failed')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}

