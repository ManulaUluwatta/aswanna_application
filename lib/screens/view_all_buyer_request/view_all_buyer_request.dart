import 'package:aswanna_application/components/custom_bottom_nav_bar.dart';
import 'package:aswanna_application/screens/view_all_buyer_request/components/body.dart';
import 'package:flutter/material.dart';

import '../../enums.dart';

class ViewAllBuyerRequestScreen extends StatelessWidget {
  static String routeName = "/view_all_buyer_request_screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("All Buyer Requests"),),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(
    selectedMenu: MenuState.favourite,
    ),
      //body: Body(),
    );
  }
}