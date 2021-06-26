import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const cPrimaryColor = Color(0xFF00E676);
const cPrimaryLightColor = Color(0xFFFAFAFA);
const cPrimaryGradiantCOlor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFB2FF59),Color(0xFFEEFF41)]
  );

const cSecondaryColor = Color(0xFFECEFF1);
const cTextColor = Color(0xFF607D8B);
const cAnimationDuration = Duration(microseconds: 200);

final RegExp emailValidatorRegExp = RegExp(r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)");
const String cEmailNullError = "Please enter your email";
const String cInvalidEmailError = "Please enter valid email";
const String cPassNullError = "Please enter your password";
const String cShortPassError = "Password is too short";
const String cMatchPassError = "Password don't match";
