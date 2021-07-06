
import 'package:aswanna_application/main.dart';
import 'package:aswanna_application/screens/complete_profile/complete_profile_screen.dart';
import 'package:aswanna_application/screens/forgot_password/forgot_password_screen.dart';
import 'package:aswanna_application/screens/home/home_screen.dart';
import 'package:aswanna_application/screens/profile/profile_screen.dart';
import 'package:aswanna_application/screens/sign_in/sign_in_screen.dart';
import 'package:aswanna_application/screens/sign_up/sign_up_screen.dart';
import 'package:aswanna_application/screens/splash/splash_screen.dart';
import 'package:aswanna_application/screens/welcome/welcome_screen.dart';
import 'package:aswanna_application/wrapper.dart';
import 'package:flutter/widgets.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName : (context) => SplashScreen(),
  SignInScreen.routeName : (context) => SignInScreen(),
  FogotPasswodScreen.routeName : (context) => FogotPasswodScreen(),
  HomeScreen.routeName : (context) => HomeScreen(),
  SignUpScreen.routeName : (context) => SignUpScreen(),
  CompleteProfileScreen.routeName : (context) => CompleteProfileScreen(),
  ProfileScreen.routeName : (context) => ProfileScreen(),
  Wrapper.routeName : (context) => Wrapper(),
  HomeContrroller.routeName : (context) => HomeContrroller(),
  WelcomeScreen.routeName : (context) => WelcomeScreen(),
};