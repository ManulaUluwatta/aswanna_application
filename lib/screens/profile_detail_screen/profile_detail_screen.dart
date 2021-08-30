import 'package:aswanna_application/components/custom_bottom_nav_bar.dart';
import 'package:aswanna_application/screens/profile_detail_screen/components/body.dart';
import 'package:flutter/material.dart';

class ProfileDetailScreen extends StatelessWidget {
  final String userID;

  const ProfileDetailScreen({
    Key key,
    @required this.userID,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: AppBar(
        title: Text("Profile Details"),
        // backgroundColor: Color(0xFFF5F6F9),
      ),
      body: Body(
        userID: userID,
      ),
      bottomNavigationBar: CustomBottomNavBar(
          // selectedMenu: MenuState.home,
        ),
    );
  }
}