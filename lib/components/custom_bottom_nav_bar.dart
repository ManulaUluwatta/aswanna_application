import 'package:aswanna_application/constrants.dart';
import 'package:aswanna_application/screens/favourites_product/favourites_product_screen.dart';
import 'package:aswanna_application/screens/home/home_screen.dart';
import 'package:aswanna_application/screens/my_buyer_request/my_buyer_request_screen.dart';
import 'package:aswanna_application/screens/my_products/my_products_screen.dart';
import 'package:aswanna_application/screens/profile/profile_screen.dart';
import 'package:aswanna_application/screens/view_all_buyer_request/view_all_buyer_request.dart';
import 'package:aswanna_application/services/database/user_database_service.dart';
import 'package:aswanna_application/size_cofig.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../enums.dart';

final Color inActiveIconColor = Color(0xFFB6B6B6);

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key key,
    this.selectedMenu,
  }) : super(key: key);
  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    // final Color inActiveIconColor = Color(0xFFB6B6B6);
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
            onPressed: () => Navigator.pushNamed(context, HomeScreen.routeName),
          ),
          // IconButton(
          //   icon: Icon(
          //     Icons.favorite,
          //     color: MenuState.favourite == selectedMenu
          //         ? cPrimaryColor
          //         : inActiveIconColor,
          //   ),
          //   onPressed: () =>
          //       Navigator.pushNamed(context, ProfileScreen.routeName),
          // ),
          
          buildUserRoleBaseMenuButtonTwo(context),
          buildUserRoleBaseMenuButtonThree(context),
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
  Widget buildUserRoleBaseMenuButtonTwo(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: UserDatabaseService().currentUserDataStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            final error = snapshot.error;
            Logger().w(error.toString());
          }
          String userRole;
          if (snapshot.hasData && snapshot.data != null) {
            userRole = snapshot.data["role"];
          }
          if (userRole == "Buyer") {
            return buildFavouriteProductsButton(context);
          }
          return buildViewAllRequestButton(context);
        });
  }

   Widget buildViewAllRequestButton(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.request_quote,
        color: MenuState.favourite == selectedMenu
            ? cPrimaryColor
            : inActiveIconColor,
      ),
      onPressed: () => Navigator.pushNamed(context, ViewAllBuyerRequestScreen.routeName),
    );
  }
  
  Widget buildFavouriteProductsButton(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.favorite,
        color: MenuState.favourite == selectedMenu
            ? cPrimaryColor
            : inActiveIconColor,
      ),
      onPressed: () => Navigator.pushNamed(context, FavouritesProductsScreen.routeName),
    );
  }

  Widget buildUserRoleBaseMenuButtonThree(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: UserDatabaseService().currentUserDataStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            final error = snapshot.error;
            Logger().w(error.toString());
          }
          String userRole;
          if (snapshot.hasData && snapshot.data != null) {
            userRole = snapshot.data["role"];
          }
          if (userRole == "Buyer") {
            return buildBuyerRequestButton(context);
          }
          return buildManageGigButton(context);
        });
  }

  Widget buildBuyerRequestButton(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.request_quote,
        color: MenuState.my_products == selectedMenu
            ? cPrimaryColor
            : inActiveIconColor,
      ),
      onPressed: () => Navigator.pushNamed(context, MyBuyerRequestScreen.routeName),
    );
  }
  
  Widget buildManageGigButton(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.shop_2,
        color: MenuState.my_products == selectedMenu
            ? cPrimaryColor
            : inActiveIconColor,
      ),
      onPressed: () => Navigator.pushNamed(context, MyProductsScreen.routeName),
    );
  }
}
