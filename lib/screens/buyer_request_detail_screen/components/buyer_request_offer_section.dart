import 'package:aswanna_application/components/top_rounded_container.dart';
import 'package:aswanna_application/constrants.dart';
import 'package:aswanna_application/models/buyer_request.dart';
import 'package:aswanna_application/models/offer.dart';
import 'package:aswanna_application/services/database/buyer_request_database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';

import '../../../size_cofig.dart';
import 'offer_box.dart';

class BuyerRequestOfferSection extends StatelessWidget {
  const BuyerRequestOfferSection({
    Key key,
    @required this.buyerRequest,
  }) : super(key: key);

  final BuyerRequest buyerRequest;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getProportionateScreenHeight(500),
      child: Stack(
        children: [
          TopRoundedContainer(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(1),
                      vertical: getProportionateScreenHeight(10)),
                  child: Text(
                    "Offer Section",
                    style: TextStyle(
                      fontSize: getProportionateScreenHeight(25),
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(10)),
                Expanded(
                  child: StreamBuilder<List<Offer>>(
                    stream: BuyerRequestDatabaseSerivce()
                        .getAllOfferStreamForRequestId(buyerRequest.id),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final offersList = snapshot.data;
                        if (offersList.length == 0) {
                          return Center(
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  // "assets/icons/review.svg",
                                  "",
                                  color: cTextColor,
                                  width: getProportionateScreenWidth(40),
                                ),
                                SizedBox(height: getProportionateScreenHeight(10)),
                                Text(
                                  "No Offers yet",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: offersList.length,
                          itemBuilder: (context, index) {
                            return OfferBox(
                              offer: offersList[index],
                            );
                          },
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        final error = snapshot.error;
                        Logger().w(error.toString());
                      }
                      return Center(
                        child: Icon(
                          Icons.error,
                          color: cTextColor,
                          size: getProportionateScreenWidth(50),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // Align(
          //   alignment: Alignment.topCenter,
          //   child: buildProductRatingWidget(product.rating),
          // ),
        ],
      ),
    );
  }
}
