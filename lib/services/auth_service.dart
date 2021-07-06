import 'package:aswanna_application/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthService with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<String?> signUp(
      {required String email, required String password}) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
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
      await auth.signInWithEmailAndPassword(
          email: email, password: password);
          return 'welcome';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    }
  }

  Future<String?> restPassword(
      {required String email}) async {
    try {
      await auth.sendPasswordResetEmail(
          email: email);
          return 'Email Send';
    } catch(e){
      return 'Error occurred';
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  // bool _isLoding = false;
  // late String _errorMessage;
  // bool get isLoding => _isLoding;
  // String get errorMessage => _errorMessage;

  // // FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  // FirebaseAuth _firebaseAuth;

  // AuthService(this._firebaseAuth);

  // Stream<User?> get authStatechanges => _firebaseAuth.idTokenChanges();

  // Future<void> signOut() async {
  //   await _firebaseAuth.signOut();
  // }

  // //Sign in method
  // Future<String?> signIn(
  //     {required String email,
  //     required String password,
  //     required BuildContext context}) async {
  //   try {
  //     await _firebaseAuth.signInWithEmailAndPassword(
  //         email: email, password: password);
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => HomeScreen()),
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     return e.message;
  //   }
  //   notifyListeners();
  // }

  // //Sign up method
  // Future<String?> signUp(
  //     {required String email,
  //     required String password,
  //     required BuildContext context}) async {
  //   try {
  //     await _firebaseAuth.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => HomeScreen()),
  //     );
  //     return 'Success';
  //   } on FirebaseAuthException catch (e) {
  //     return e.message;
  //   }
  // }

  // sign up method
  // Future signUp(
  //     {required String email, required String password}) async {
  //   setLoading(true);
  //   try {
  //     UserCredential authResult = await FirebaseAuth.instance
  //         .createUserWithEmailAndPassword(email: email, password: password);
  //     User? user = authResult.user;
  //     setLoading(false);
  //     return user;
  //   } on FirebaseAuthException catch (e) {
  //     setLoading(false);
  //     if (e.code == 'weak-password') {
  //       print('The password provided is too weak.');
  //     } else if (e.code == 'email-already-in-use') {
  //       print('The account already exists for that email.');
  //     }
  //   } catch (e) {
  //     setLoading(false);
  //     print(e);
  //   }
  //   notifyListeners();
  // }
  // //sign in method
  // Future signIn(
  //     {required String email, required String password}) async {
  //   setLoading(true);
  //   try {
  //     UserCredential authResult = await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(email: email, password: password);
  //     User? user = authResult.user;
  //     setLoading(false);
  //     return user;
  //   } on FirebaseAuthException catch (e) {
  //     setLoading(false);
  //     if (e.code == 'user-not-found') {
  //       print('No user found for that email.');
  //       return e.message;
  //     } else if (e.code == 'wrong-password') {
  //       print('Wrong password provided for that user.');
  //     }
  //   }catch (e){
  //     setLoading(false);
  //     print(e);
  //   }
  //   notifyListeners();
  // }

  // Future signOut() async{
  //   await firebaseAuth.signOut();
  // }

  // void setLoading(val) {
  //   _isLoding = val;
  //   notifyListeners();
  // }

  // void setMessage(message){
  //   _isLoding = message;
  //   notifyListeners();
  // }

  // //sign in anonymously
  // Future signInAnonymously() async {
  //   try {
  //     UserCredential userCredential = await firebaseAuth.signInAnonymously();
  //     // User? user = userCredential.user;

  //     return userCredential;
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  // Stream<User?> get user => firebaseAuth.authStateChanges().map((event) => event);

}
