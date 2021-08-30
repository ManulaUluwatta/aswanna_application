import 'package:aswanna_application/screens/home/components/product_section.dart';
import 'package:aswanna_application/screens/product_details/product_details_screen.dart';
import 'package:aswanna_application/services/data_streem/favourite_products_stream.dart';
import 'package:flutter/material.dart';

import '../../../size_cofig.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final FavouriteProductsStream favouriteProductsStream =
      FavouriteProductsStream();

  @override
  void initState() {
    super.initState();
    favouriteProductsStream.init();
  }

  @override
  void dispose() {
    favouriteProductsStream.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: refreshPage,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: getProportionateScreenWidth(30),
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 1,
                child: ProductSection(
                  sectionTitle: "Products You Like",
                  productsSteamController: favouriteProductsStream,
                  emptyMessage: "Add Product to Favourites",
                  onCardTap: onProductCardTapped,
                ),
              ),
              SizedBox(
                height: getProportionateScreenWidth(0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> refreshPage() {
    // favouriteProductsStream.reload();
    favouriteProductsStream.reload();
    return Future<void>.value();
  }

  void onProductCardTapped(String productId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(productId: productId),
      ),
    ).then((_) async {
      await refreshPage();
    });
  }
}