import 'package:aswanna_application/screens/sign_in/sign_in_screen.dart';
import 'package:aswanna_application/services/auth/auth_service.dart';
import 'package:aswanna_application/services/custom/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userData =
        UserService().getById(FirebaseAuth.instance.currentUser!.uid);
    return Column(
      children: [
        ProfilePic(),
        SizedBox(
          height: 20,
        ),
        ProfileMenu(
          pic: Icons.person_rounded,
          text: "My Account",
          press: () {},
        ),
        ProfileMenu(
          pic: Icons.notifications,
          text: "Notifications",
          press: () {},
        ),
        ProfileMenu(
          pic: Icons.settings,
          text: "Settings",
          press: () {},
        ),
        ProfileMenu(
          pic: Icons.help_center_outlined,
          text: "Help Center",
          press: () {},
        ),
        ProfileMenu(
          pic: Icons.logout,
          text: "Log out",
          press: () {
            AuthService().signOut();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => SignInScreen()),
                (route) => false);
          },
        ),
      ],
    );
  }
}
