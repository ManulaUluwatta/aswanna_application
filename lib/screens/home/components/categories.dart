import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../size_cofig.dart';

class Categories extends StatelessWidget {
  const Categories({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/images/fruit.png", "text": "Fruits"},
      {"icon": "assets/images/vegi.png", "text": "Vegetables"},
      {"icon": "assets/images/rice.png", "text": "Rice"},
    ];
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
              categories.length,
              (index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: CategoryCard(
                  icon: categories[index]["icon"],
                  text: categories[index]["text"],
                  press: () {},
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
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(icon),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              text,
              style: TextStyle(
                fontSize: getProportionateScreenWidth(35),
                fontWeight: FontWeight.w500
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
