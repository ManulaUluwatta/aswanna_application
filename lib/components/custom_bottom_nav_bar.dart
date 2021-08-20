import 'package:aswanna_application/constrants.dart';
import 'package:aswanna_application/screens/profile/profile_screen.dart';
import 'package:aswanna_application/size_cofig.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../enums.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key key,
    this.selectedMenu,
  }) : super(key: key);
  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 30,
            color: Color(0xFFDADADA).withOpacity(0.5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(
              Icons.storefront,
              color: MenuState.home == selectedMenu
                  ? cPrimaryColor
                  : inActiveIconColor,
            ),
            onPressed: () =>
                Navigator.pushNamed(context, ProfileScreen.routeName),
          ),
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: MenuState.favourite == selectedMenu
                  ? cPrimaryColor
                  : inActiveIconColor,
            ),
            onPressed: () =>
                Navigator.pushNamed(context, ProfileScreen.routeName),
          ),
          IconButton(
            icon: Icon(
              Icons.chat_outlined,
              color: MenuState.message == selectedMenu
                  ? cPrimaryColor
                  : inActiveIconColor,
            ),
            onPressed: () =>
                Navigator.pushNamed(context, ProfileScreen.routeName),
          ),
          IconButton(
            icon: Icon(
              Icons.person_rounded,
              color: MenuState.profile == selectedMenu
                  ? cPrimaryColor
                  : inActiveIconColor,
            ),
            onPressed: () =>
                Navigator.pushNamed(context, ProfileScreen.routeName),
          ),
        ],
      ),
    );
  }
}
