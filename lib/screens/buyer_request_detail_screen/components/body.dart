import 'package:aswanna_application/models/buyer_request.dart';
import 'package:aswanna_application/screens/buyer_request_detail_screen/components/buyer_request_actions_section.dart';
import 'package:aswanna_application/screens/buyer_request_detail_screen/components/buyer_request_offer_section.dart';
import 'package:aswanna_application/services/database/buyer_request_database_service.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../../constrants.dart';
import '../../../size_cofig.dart';

class Body extends StatelessWidget {
  final String buyerRequestID;

  const Body({
    Key key,
    @required this.buyerRequestID,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20)),
          child: FutureBuilder<BuyerRequest>(
            future: BuyerRequestDatabaseSerivce().getBuyerRequestWithID(buyerRequestID),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final buyerRequest = snapshot.data;
                return Column(
                  children: [
                    // ProductImages(product: product),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    BuyerRequestActionSection(buyerRequest: buyerRequest),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    BuyerRequestOfferSection(buyerRequest: buyerRequest),
                    SizedBox(height: getProportionateScreenHeight(100)),
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                final error = snapshot.error.toString();
                Logger().e(error);
              }
              return Center(
                child: Icon(
                  Icons.error,
                  color: cTextColor,
                  size: 60,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}