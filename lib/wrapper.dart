

import 'package:aswanna_application/screens/home/home_screen.dart';
import 'package:aswanna_application/screens/sign_in/sign_in_screen.dart';
import 'package:aswanna_application/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  static String routeName = "/wrapperScreen";
  const Wrapper({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user != null) {
      // Navigator.pushNamed(context, HomeScreen.routeName);
      print(user);
      return HomeScreen();
      
    } else {
      // Navigator.pushNamed(context, SignInScreen.routeName);
      return SignInScreen();
    }
   

  }
}
