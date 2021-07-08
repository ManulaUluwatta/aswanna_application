import 'dart:ui';

import 'package:aswanna_application/components/product_card.dart';
import 'package:aswanna_application/constrants.dart';
import 'package:aswanna_application/models/product.dart';
import 'package:aswanna_application/screens/home/components/icon_btn_with_counter.dart';
import 'package:aswanna_application/screens/home/components/popular_product.dart';
import 'package:aswanna_application/screens/home/components/search_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:aswanna_application/size_cofig.dart';
import '../../../size_cofig.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'selection_title.dart';
import 'special_offers.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

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

