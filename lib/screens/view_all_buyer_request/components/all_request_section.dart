import 'package:aswanna_application/components/buyer_request_short_detail_card.dart';
import 'package:aswanna_application/components/nothing_to_show_container.dart';
import 'package:aswanna_application/services/data_streem/data_stream.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../../size_cofig.dart';
import 'buyer_request_section.dart';

class AllRequestSection extends StatelessWidget {
  const AllRequestSection(
      {Key key,
      @required this.sectionTitle,
      @required this.allRequestStreamController,
      this.emptyMessage = "No product to show here",
      @required this.onCardTap})
      : super(key: key);
  final String sectionTitle;
  final DataStream allRequestStreamController;
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
            horizontal: getProportionateScreenWidth(4),
            vertical: getProportionateScreenHeight(10)),
        decoration: BoxDecoration(
          color: Color(0xFFE8F5E9),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            RequestSectionTitle(
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
      stream: allRequestStreamController.stream,
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

  Widget buildProductGrid(List<String> requestIds) {
    return ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //   crossAxisCount: 1,
      //   childAspectRatio: 4,
      //   crossAxisSpacing: 5,
      //   mainAxisSpacing: 7,
      // ),
      itemCount: requestIds.length,
      itemBuilder: (context, index) {
        return BuyerRequestShortDetailCard(
            buyerRequestID: requestIds[index],
            onPressed: () {
              onCardTap.call(requestIds[index]);
            });
        // (
        //   productId: productsId[index],
        //   press: () {
        //     onCardTap.call(productsId[index]);
        //   },
        // );
      },
    );
  }
}
