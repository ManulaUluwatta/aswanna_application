import 'package:aswanna_application/components/nothing_to_show_container.dart';
import 'package:aswanna_application/components/product_card.dart';
import 'package:aswanna_application/services/data_streem/data_stream.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../../size_cofig.dart';
import 'selection_title.dart';

// class PopularProductSection extends StatelessWidget {
//   const PopularProductSection(
//       {Key key,
//       @required this.sectionTitle,
//       @required this.productsSteamController,
//       this.emptyMessage = "No product to show here",
//       @required this.onCardTap})
//       : super(key: key);
//   final String sectionTitle;
//   final DataStream productsSteamController;
//   final String emptyMessage;
//   final Function onCardTap;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//           horizontal: getProportionateScreenWidth(15),
//           vertical: getProportionateScreenHeight(15)),
//       child: Container(
//         padding: EdgeInsets.symmetric(
//             horizontal: getProportionateScreenWidth(20),
//             vertical: getProportionateScreenHeight(20)),
//         decoration: BoxDecoration(
//           color: Color(0xFFE8F5E9),
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: Column(
//           children: [
//             SectionTitle(
//               title: sectionTitle,
//               press: () {},
//             ),
//             SizedBox(
//               height: getProportionateScreenHeight(15),
//             ),
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children: [
//                   buildProductList(),
//                   SizedBox(
//                     width: getProportionateScreenWidth(20),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildProductList() {
//     return StreamBuilder<List<String>>(
//       stream: productsSteamController.stream,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           if (snapshot.data.length == 0) {
//             return Center(
//               child: NothingToShowContainer(
//                 iconPath: "assets/icons/empty_box.svg",
//                 secondaryMessage: emptyMessage,
//               ),
//             );
//           }
//           return buildProductGrid(snapshot.data);
//         } else if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         } else if (snapshot.hasError) {
//           final error = snapshot.error;
//           Logger().w(error.toString());
//         }
//         return Center(
//           child: NothingToShowContainer(
//             iconPath: "assets/icons/network_error.svg",
//             primaryMessage: "Something went wrong",
//             secondaryMessage: "Unable to connect to Database",
//           ),
//         );
//       },
//     );
//   }

//   Widget buildProductGrid(List<String> productsId) {
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: BouncingScrollPhysics(),
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         childAspectRatio: 0.6,
//         crossAxisSpacing: 5,
//         mainAxisSpacing: 7,
//       ),
//       itemCount: productsId.length,
//       itemBuilder: (context, index) {
//         return ProductsCard(
//           productId: productsId[index],
//           press: () {
//             onCardTap.call(productsId[index]);
//           },
//         );
//       },
//     );
//   }
// }

class SpecialOffers extends StatelessWidget {
  const SpecialOffers({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
          title: "Special for you",
          press: () {}, //behaviour
        ),
        SizedBox(
          height: getProportionateScreenWidth(20),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SpecialOfferCard(
                image: "assets/images/vegi.png", //assign values
                category: "Vegitables", //assign values
                numOfBrands: 18, //assign values
                press: () {}, //behaviour
              ),
              SpecialOfferCard(
                image: "assets/images/fruit.png", //assign values
                category: "fruits", //assign values
                numOfBrands: 10, //assign values
                press: () {}, //behaviour
              ),
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

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key key,
    this.category,
    this.image,
    this.numOfBrands,
    this.press,
  }) : super(key: key);
  final String category, image;
  final int numOfBrands;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: getProportionateScreenWidth(20),
      ),
      child: SizedBox(
        width: getProportionateScreenWidth(420),
        height: getProportionateScreenWidth(200),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Image.asset(
                image,
                fit: BoxFit.cover,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xFF343434).withOpacity(0.4),
                      Color(0xFF343434).withOpacity(0.15),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(15),
                  vertical: getProportionateScreenWidth(10),
                ),
                child: Text.rich(
                  TextSpan(
                    style: TextStyle(color: Colors.white),
                    children: [
                      TextSpan(
                        text: "$category\n",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(50),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(text: "$numOfBrands varieties"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
