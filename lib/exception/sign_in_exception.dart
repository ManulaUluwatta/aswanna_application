import 'package:aswanna_application/exception/supper_exception_message_firebase_auth.dart';

// ignore: must_be_immutable
class SignInExeption extends SupperExceptionMessageFirebaseAuth {
  SignInExeption({required String message})
      : super(message);
}

// ignore: must_be_immutable
class UserNotFoundException extends SignInExeption{
  UserNotFoundException(
      {String message = "No such user found"})
      : super(message: message);
}

// ignore: must_be_immutable
class SignInAuthInvalidEmailException
    extends SignInExeption {
  SignInAuthInvalidEmailException(
      {String message = "Email is not valid"})
      : super(message: message);
}

// ignore: must_be_immutable
class WrongPasswordException
    extends SignInExeption {
  WrongPasswordException({String message = "Wrong password"})
      : super(message: message);
}

// ignore: must_be_immutable
class SignInAuthUserNotVerifiedException
    extends SignInExeption {
  SignInAuthUserNotVerifiedException(
      {String message = "This user is not verified"})
      : super(message: message);
}

// ignore: must_be_immutable
class SignInAuthUserDisabledException
    extends SignInExeption {
  SignInAuthUserDisabledException(
      {String message = "This user is disabled"})
      : super(message: message);
}
// ignore: must_be_immutable
class SignInAuthUnknownReasonFailure
    extends SignInExeption {
  SignInAuthUnknownReasonFailure(
      {String message = "Sign in failed due to unknown reason"})
      : super(message: message);
}

