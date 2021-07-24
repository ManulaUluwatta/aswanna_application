import 'package:aswanna_application/screens/home/components/popular_product.dart';
import 'package:aswanna_application/screens/home/components/product_section.dart';
import 'package:aswanna_application/services/data_streem/all_products_stream.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:aswanna_application/size_cofig.dart';
import '../../../size_cofig.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'special_offers.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final AllProductsStream allProductsStream = AllProductsStream();

  @override
  void initState() {
    super.initState();
    allProductsStream.init();
  }

  @override
  void dispose() {
    allProductsStream.dispose();
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
                height: getProportionateScreenWidth(20),
              ),
              HomeHeader(),
              SizedBox(
                height: getProportionateScreenWidth(30),
              ),
              DiscountBanner(),
              SizedBox(
                height: getProportionateScreenWidth(30),
              ),
              Categories(),
              SizedBox(
                height: getProportionateScreenWidth(30),
              ),
              SpecialOffers(),
              SizedBox(
                height: getProportionateScreenWidth(30),
              ),
              // PopularProduct(),
              SizedBox(
                height: SizeConfig.screenHeight * 0.8,
                child: ProductSection(
                  sectionTitle: "Explore All Products",
                  productsSteamController: allProductsStream,
                  emptyMessage: "Looks like all Stores are closed",
                  onCardTap: onProductCardTapped,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
   Future<void> refreshPage() {
    // favouriteProductsStream.reload();
    allProductsStream.reload();
    return Future<void>.value();
  }

  void onProductCardTapped(String productId) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => ProductDetailsScreen(productId: productId),
    //   ),
    // ).then((_) async {
    //   await refreshPage();
    // });
  }
}
