import 'package:firebase_auth/firebase_auth.dart';

class SupperExceptionMessageFirebaseAuth extends FirebaseAuthException{
  String _message;

  SupperExceptionMessageFirebaseAuth(this._message) : super(code: _message);
  
  String get message => _message;
  @override
  String toString() {
    print(message);
    return message;
  }
}