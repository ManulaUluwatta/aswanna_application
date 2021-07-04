import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //sign in method
  Future<String> signIn(
      {required String email, required String password}) async {
    try {
  UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: "barry.allen@example.com",
    password: "SuperSecretPassword!"
  );
} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    print('No user found for that email.');
  } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
  }
}
  return "";
  }

  //sign up method
  // Future<String> signUp({required String email,required String password}){

  //   return "";
  // }

  //sign in anonymously
  Future signInAnonymously() async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInAnonymously();
      // User? user = userCredential.user;

      return userCredential;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
