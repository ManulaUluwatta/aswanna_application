import 'package:aswanna_application/components/nothing_to_show_container.dart';
import 'package:aswanna_application/components/product_card.dart';
import 'package:aswanna_application/screens/home/components/selection_title.dart';
import 'package:aswanna_application/services/data_streem/data_stream.dart';
import 'package:aswanna_application/size_cofig.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class ProductSection extends StatelessWidget {
  const ProductSection(
      {Key key,
      @required this.sectionTitle,
      @required this.productsSteamController,
      this.emptyMessage = "No product to show here",
      @required this.onCardTap})
      : super(key: key);
  final String sectionTitle;
  final DataStream productsSteamController;
  final String emptyMessage;
  final Function onCardTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(15),
          vertical: getProportionateScreenHeight(15)),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: getProportionateScreenHeight(20)),
        decoration: BoxDecoration(
          color: Color(0xFFE8F5E9),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            SectionTitle(
              title: sectionTitle,
              press: () {},
            ),
            SizedBox(
              height: getProportionateScreenHeight(15),
            ),
            Expanded(
              child: buildProductList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProductList() {
    return StreamBuilder<List<String>>(
      stream: productsSteamController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length == 0) {
            return Center(
              child: NothingToShowContainer(
                iconPath: "assets/icons/empty_box.svg",
                secondaryMessage: emptyMessage,
              ),
            );
          }
          return buildProductGrid(snapshot.data);
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          final error = snapshot.error;
          Logger().w(error.toString());
        }
        return Center(
          child: NothingToShowContainer(
            iconPath: "assets/icons/network_error.svg",
            primaryMessage: "Something went wrong",
            secondaryMessage: "Unable to connect to Database",
          ),
        );
      },
    );
  }

  Widget buildProductGrid(List<String> productsId) {
    return GridView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: getProportionateScreenHeight(0.7),
        crossAxisSpacing: getProportionateScreenWidth(8),
        mainAxisSpacing: getProportionateScreenHeight(8),
      ),
      itemCount: productsId.length,
      itemBuilder: (context, index) {
        return ProductsCard(
          productId: productsId[index],
          press: () {
            onCardTap.call(productsId[index]);
          },
        );
      },
    );
  }
}
