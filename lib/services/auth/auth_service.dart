import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthService with ChangeNotifier {
  static const String USER_NOT_FOUND_EXCEPTION_CODE = "user-not-found";
  static const String WRONG_PASSWORD_EXCEPTION_CODE = "wrong-password";
  static const String EMAIL_ALREADY_IN_USE_EXCEPTION_CODE =
      "email-already-in-use";
  static const String OPERATION_NOT_ALLOWED_EXCEPTION_CODE =
      "operation-not-allowed";
  static const String WEAK_PASSWORD_EXCEPTION_CODE = "weak-password";
  static const String USER_MISMATCH_EXCEPTION_CODE = "user-mismatch";
  static const String INVALID_CREDENTIALS_EXCEPTION_CODE = "invalid-credential";
  static const String INVALID_EMAIL_EXCEPTION_CODE = "invalid-email";
  static const String USER_DISABLED_EXCEPTION_CODE = "user-disabled";
  static const String INVALID_VERIFICATION_CODE_EXCEPTION_CODE =
      "invalid-verification-code";
  static const String INVALID_VERIFICATION_ID_EXCEPTION_CODE =
      "invalid-verification-id";
  static const String REQUIRES_RECENT_LOGIN_EXCEPTION_CODE =
      "requires-recent-login";

  static FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => auth.authStateChanges();

  Stream<User?> get userChanges => auth.userChanges();

  Future<String?> signUp(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user!.emailVerified == false) {
        await userCredential.user!.sendEmailVerification();
      }
      return "SignUp";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    } catch (e) {
      return "Error occured";
    }
  }

  Future<String?> signIn(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user!.emailVerified) {
        return "welcome";
      } else {
        log("sending...");
        await userCredential.user!.sendEmailVerification();
      }
     } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // SnackBar(content: Text("No user found for that email."),);
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    }
  }

  Future<String?> restPassword({required String email}) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      return 'Email Send';
    } catch (e) {
      return 'Error occurred';
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  Future<void> deleteUserAccount() async {
    await auth.currentUser!.delete();
    await signOut();
  }

  bool get currentUserVerified {
    auth.currentUser!.reload();
    return auth.currentUser!.emailVerified;
  }

  Future<void> sendEmailVerification() async {
    await auth.currentUser!.sendEmailVerification();
  }

  Future<void> updateCurrentUserDisplayName(String name) async {
    await auth.currentUser!.updateDisplayName(name);
  }
}
