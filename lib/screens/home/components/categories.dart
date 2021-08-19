import 'package:aswanna_application/models/product.dart';
import 'package:aswanna_application/screens/category_products/category_products_screen.dart';
import 'package:flutter/material.dart';
import '../../../size_cofig.dart';

const String ICON_KEY = "icon";
const String TITLE_KEY = "title";
const String PRODUCT_TYPE_KEY = "product_type";

class Categories extends StatelessWidget {
  const Categories({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productCategories = <Map>[
      <String, dynamic>{
        ICON_KEY: "assets/images/fruit.png",
        TITLE_KEY: "Fruit",
        PRODUCT_TYPE_KEY: ProductType.FRUIT,
      },
      <String, dynamic>{
        ICON_KEY: "assets/images/vegi.png",
        TITLE_KEY: "Vegitable",
        PRODUCT_TYPE_KEY: ProductType.VEGITABLE,
      },
      <String, dynamic>{
        ICON_KEY: "assets/images/rice.png",
        TITLE_KEY: "Rice",
        PRODUCT_TYPE_KEY: ProductType.RICE,
      },
    ];

    // List<Map<String, dynamic>> categories = [
    //   {"icon": "assets/images/fruit.png", "text": "Fruits"},
    //   {"icon": "assets/images/vegi.png", "text": "Vegetables"},
    //   {"icon": "assets/images/rice.png", "text": "Rice"},
    // ];
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...List.generate(
              productCategories.length,
              (index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: CategoryCard(
                  icon: productCategories[index][ICON_KEY],
                  text: productCategories[index][TITLE_KEY],
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryProductsScreen(
                          productType: productCategories[index]
                              [PRODUCT_TYPE_KEY],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key key,
    this.icon,
    this.text,
    this.press,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(250),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                padding: EdgeInsets.all(
                  getProportionateScreenWidth(15),
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(icon),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              text,
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(35),
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
