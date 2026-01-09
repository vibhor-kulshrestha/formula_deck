import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Service for managing authentication and bookmark sync
class AuthService {
  static FirebaseAuth? _auth;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// Initialize Firebase Auth (call after Firebase.initializeApp())
  static void _ensureInitialized() {
    try {
      _auth ??= FirebaseAuth.instance;
    } catch (e) {
      debugPrint('Firebase Auth not available: $e');
      _auth = null;
    }
  }

  /// Get current user
  static User? get currentUser {
    _ensureInitialized();
    return _auth?.currentUser;
  }

  /// Check if user is signed in
  static bool get isSignedIn {
    _ensureInitialized();
    return _auth?.currentUser != null;
  }

  /// Sign in with Google
  static Future<UserCredential?> signInWithGoogle() async {
    try {
      _ensureInitialized();
      if (_auth == null) {
        debugPrint('Firebase Auth not initialized');
        return null;
      }

      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase
      return await _auth!.signInWithCredential(credential);
    } catch (e) {
      debugPrint('Error signing in with Google: $e');
      return null;
    }
  }

  /// Sign out
  static Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      _ensureInitialized();
      if (_auth != null) {
        await _auth!.signOut();
      }
    } catch (e) {
      debugPrint('Error signing out: $e');
    }
  }
}
