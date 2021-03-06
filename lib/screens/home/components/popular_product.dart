import 'package:flutter/material.dart';
import '../../../size_cofig.dart';
import 'package:aswanna_application/screens/home/components/selection_title.dart';

class PopularProduct extends StatelessWidget {
  const PopularProduct({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         SectionTitle(title: "Best Selling", press: () {}),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              // ...List.generate(
              //   demoProducts.length,
              //   (index) => ProductsCard(
              //     product: demoProducts[index],
              //   ),
              // ),
              SizedBox(
                width: getProportionateScreenWidth(20),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
