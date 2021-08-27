import 'package:aswanna_application/components/custom_bottom_nav_bar.dart';
import 'package:aswanna_application/screens/my_buyer_request/components/body.dart';
import 'package:flutter/material.dart';

import '../../enums.dart';

class MyBuyerRequestScreen extends StatelessWidget {
  static String routeName = "/my_buyer_request_screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Manage Buyer Request"),),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(
    selectedMenu: MenuState.my_products,
    ),
      //body: Body(),
    );
  }
}