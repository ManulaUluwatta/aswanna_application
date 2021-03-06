import 'package:aswanna_application/components/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import '../../enums.dart';
import 'components/body.dart';

class MyProductsScreen extends StatelessWidget {
  static String routeName = "/my_product_screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Manage Products"),),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(
    selectedMenu: MenuState.my_products,
    ),
      //body: Body(),
    );
  }
}
