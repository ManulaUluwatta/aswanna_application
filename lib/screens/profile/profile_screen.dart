import 'package:aswanna_application/components/custom_bottom_nav_bar.dart';
import 'package:aswanna_application/enums.dart';
import 'package:flutter/material.dart';
import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {    
    return Scaffold(      
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(
      selectedMenu: MenuState.profile,
      
        ),
    );
  }
}
