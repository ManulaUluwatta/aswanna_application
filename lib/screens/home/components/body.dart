
import 'package:aswanna_application/screens/home/components/popular_product.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:aswanna_application/size_cofig.dart';
import '../../../size_cofig.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'special_offers.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
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
            PopularProduct(),
          ],
        ),
      ),
    );
  }
}

