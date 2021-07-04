import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  


  //sign in anonymously
  Future signInAnonymously() async {
    try{
      UserCredential userCredential = await _firebaseAuth.signInAnonymously();
      // User? user = userCredential.user;
      
      return userCredential;

    }catch(e){
      print(e.toString());
      return null;
    }
  }



}