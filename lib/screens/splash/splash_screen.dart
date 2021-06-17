import 'package:aswanna_application/screens/components/body.dart';
import 'package:aswanna_application/size_cofig.dart';
import 'package:flutter/material.dart';
import '../components/body.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    Body body = Body();
    
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
      
      bottomSheet: 
      Body().getSheet(),
    );
  }
}