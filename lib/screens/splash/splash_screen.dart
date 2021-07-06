
import 'package:aswanna_application/screens/home/home_screen.dart';
import 'package:aswanna_application/screens/sign_in/components/sign_form.dart';
import 'package:aswanna_application/screens/sign_in/sign_in_screen.dart';
import 'package:aswanna_application/screens/sign_up/sign_up_screen.dart';
import 'package:aswanna_application/services/auth_service.dart';
import 'package:aswanna_application/size_cofig.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'components/body.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  static int currentPageSplash = 0;

  updateCurrentPage(int i) {
    currentPageSplash = i;
    build(context);
  }
  late final firebaseUser;
  // state, updateCurrentPage

  @override
  Widget build(BuildContext context) {

    // print('Test$currentPageSplash');
    // Body body = Body();
    // updateCurrentPage(currentPageSplash);
    SizeConfig().init(context);
    // firebaseUser = context.watch<User>();
   
 
    // if (firebaseUser != null) {
    //   print("User is alredy sign in");
    //   return HomeScreen();
    // }
    // Future.delayed(const Duration(seconds: 2),(){
    //   if (auth.currentUser == null) {
    //     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SignInScreen()), 
    //     (route) => false);
    //   }else{
    //     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen()), 
    //     (route) => false);
    //   }
    // });

   
    return Scaffold(
      body: Body(),
    );
    // if (currentPageSplash == 2) {
    //   return Scaffold(
    //     backgroundColor: Color(0xFF41c300),
    //     body: Body(currentPageSplash, updateCurrentPage),
    //     // bottomSheet: currentPageSplash == 2
    //     //     ? Container(
    //     //         height: 80.0,
    //     //         color: Colors.white,
    //     //       )
    //     //     : Text("data"),
    //   );
    // } else {
    //   return Scaffold(
    //       backgroundColor: Color(0xFF41c300),
    //       body: Body(currentPageSplash, updateCurrentPage));
    // }
  }

}


