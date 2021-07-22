import 'package:aswanna_application/components/custom_bottom_nav_bar.dart';
import 'package:aswanna_application/enums.dart';
import 'package:aswanna_application/screens/home/components/body.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({ Key key }) : super(key: key);
  static String routeName = "/home_screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(       
    body:Body(),
    bottomNavigationBar: CustomBottomNavBar(
    selectedMenu: MenuState.home,
    ),     

    );
  }
}