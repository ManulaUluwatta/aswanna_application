import 'package:aswanna_application/size_cofig.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'components/body.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  // final firebaseUser;
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
      backgroundColor: Color(0xFF41c300),
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
