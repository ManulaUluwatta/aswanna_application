import 'package:aswanna_application/components/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'components/body.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cart"),),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(
          // selectedMenu: MenuState.home,
        ),
    );
  }
}
