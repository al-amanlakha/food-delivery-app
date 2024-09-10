import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  FirebaseAuth get auth => _auth;

  // This method signs up a user and returns UserCredential on success
  Future<UserCredential> signUpWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return result; // Return UserCredential directly
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(
          code: e.code,
          message: e
              .message); // Throw FirebaseAuthException to be caught by the caller
    }
  }

  // This method signs in a user and returns UserCredential on success
  Future<UserCredential> signInWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .timeout(const Duration(seconds: 20));
      return result; // Return UserCredential directly
    } on TimeoutException catch (_) {
      throw TimeoutException('Request Timeout'); // Throw TimeoutException
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(
          code: e.code,
          message: e
              .message); // Throw FirebaseAuthException to be caught by the caller
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      // Re-throw the FirebaseAuthException to be handled by the caller
      throw FirebaseAuthException(code: e.code, message: e.message);
    } on Exception catch (e) {
      // Re-throw any other exceptions that might occur
      throw Exception('Failed to sign in with Google: ${e.toString()}');
    }
  }

  Future<void> signOut() async {
    try {
      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut(); // Sign out from Google first
      }
      await _auth.signOut(); // Then sign out from Firebase Auth
    } catch (e) {
      throw Exception('Failed to sign out: ${e.toString()}');
    }
  }

  Future<UserCredential> signInWithPhone(
      String phoneNumber, Function(String, int?) onCodeSent) async {
    try {
      final completer = Completer<UserCredential>();

      await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            // Auto-resolve the SMS code if possible
            final UserCredential userCredential =
                await _auth.signInWithCredential(credential);
            if (!completer.isCompleted) completer.complete(userCredential);
          },
          verificationFailed: (FirebaseAuthException e) {
            if (!completer.isCompleted)
              completer.completeError(
                  FirebaseAuthException(code: e.code, message: e.message));
          },
          codeSent: (String verificationId, int? resendToken) {
            onCodeSent(verificationId, resendToken);
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            if (!completer.isCompleted)
              completer.completeError(
                  TimeoutException("Verification code auto retrieval timeout"));
          },
          timeout: const Duration(
              seconds: 120) // Timeout for the code sent to the phone
          );

      return await completer
          .future; // This will complete when the user signs in or an error happens
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(
          code: e.code,
          message: e
              .message); // Re-throw FirebaseAuthException to be caught by the caller
    } catch (e) {
      throw Exception(
          'Failed to sign in with Phone: ${e.toString()}'); // Handle any other exceptions
    }
  }
}
