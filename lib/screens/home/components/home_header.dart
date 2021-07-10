import 'package:flutter/material.dart';

import '../../../size_cofig.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(),
          IconBtnWithCounter(
            iconSrc: Icons.shopping_cart,
            press: () {}, //assign the behaviour
          ),
          IconBtnWithCounter(
            iconSrc: Icons.notifications,
            numOfItems: 4, //pass the related value
            press: () {}, //assign the behaviour
          ),
        ],
      ),
    );
  }
}
