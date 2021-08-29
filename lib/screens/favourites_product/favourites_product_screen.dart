import 'package:aswanna_application/components/custom_bottom_nav_bar.dart';
import 'package:aswanna_application/screens/favourites_product/components/body.dart';
import 'package:flutter/material.dart';

import '../../enums.dart';

class FavouritesProductsScreen extends StatelessWidget {
  
  static String routeName = "/favourites_product_screen";
  const FavouritesProductsScreen({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favourites products"),),
      body: Body(), 
      bottomNavigationBar: CustomBottomNavBar(
    selectedMenu: MenuState.favourite,
    ),
    );
  }
}