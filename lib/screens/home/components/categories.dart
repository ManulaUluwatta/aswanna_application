import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../size_cofig.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"Icon": "assets/images/fruit.svg", "text": "fruits"},
      {
        "Icon":
            "assets/images/iconfinder_7498444_fruit_vegetables_pumpkin_outline_icon.svg",
        "text": "Vegetables"
      },
      {"Icon": "assets/images/rice.svg", "text": "Rice"},
    ];
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ...List.generate(
          //   categories.length,
          //   (index) => CategoryCard(
          //     icon: categories[index]["icon"],
          //     text: categories[index]["text"],
          //     press: () {},
          //   ),
          // ),
          /* Exception caught by widgets library ═══════════════════════════════════
The following _TypeError was thrown building Categories(dirty):
type 'Null' is not a subtype of type 'String'

The relevant error-causing widget was
Categories
lib\…\components\body.dart:33
When the exception was thrown, this was the stack
#0      Categories.build.<anonymous closure>
package:aswanna_application/…/components/categories.dart:30
#1      new _GrowableList.generate (dart:core-patch/growable_array.dart:133:28)
#2      Categories.build
package:aswanna_application/…/components/categories.dart:27 */

        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(55),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                padding: EdgeInsets.all(
                  getProportionateScreenWidth(15),
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFECDF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SvgPicture.asset(icon),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              text,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
