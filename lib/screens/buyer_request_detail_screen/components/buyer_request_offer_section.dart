import 'package:aswanna_application/components/top_rounded_container.dart';
import 'package:aswanna_application/models/buyer_request.dart';
import 'package:flutter/material.dart';

import '../../../size_cofig.dart';

class BuyerRequestOfferSection extends StatelessWidget {
  const BuyerRequestOfferSection({
    Key key,
    @required this.buyerRequest,
  }) : super(key: key);

  final BuyerRequest buyerRequest;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getProportionateScreenHeight(400),
      child: Stack(
        children: [
          TopRoundedContainer(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                // Expanded(
                //   child: StreamBuilder<List<Review>>(
                //     stream: ProductDatabaseService()
                //         .getAllReviewsStreamForProductId(product.id),
                //     builder: (context, snapshot) {
                //       if (snapshot.hasData) {
                //         final reviewsList = snapshot.data;
                //         if (reviewsList.length == 0) {
                //           return Center(
                //             child: Column(
                //               children: [
                //                 SvgPicture.asset(
                //                   "assets/icons/review.svg",
                //                   color: cTextColor,
                //                   width: getProportionateScreenWidth(40),
                //                 ),
                //                 SizedBox(height: 8),
                //                 Text(
                //                   "No reviews yet",
                //                   style: TextStyle(
                //                     fontWeight: FontWeight.bold,
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           );
                //         }
                //         return ListView.builder(
                //           physics: BouncingScrollPhysics(),
                //           itemCount: reviewsList.length,
                //           itemBuilder: (context, index) {
                //             return ReviewBox(
                //               review: reviewsList[index],
                //             );
                //           },
                //         );
                //       } else if (snapshot.connectionState ==
                //           ConnectionState.waiting) {
                //         return Center(
                //           child: CircularProgressIndicator(),
                //         );
                //       } else if (snapshot.hasError) {
                //         final error = snapshot.error;
                //         Logger().w(error.toString());
                //       }
                //       return Center(
                //         child: Icon(
                //           Icons.error,
                //           color: cTextColor,
                //           size: 50,
                //         ),
                //       );
                    // },
                  // ),
                // ),
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

  Widget buildProductRatingWidget(num rating) {
    return Container(
      width: getProportionateScreenWidth(140),
      padding: EdgeInsets.all(getProportionateScreenWidth(10)),
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              "$rating",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: getProportionateScreenWidth(35),
              ),
            ),
          ),
          SizedBox(width: getProportionateScreenWidth(10)),
          Icon(
            Icons.star,
            color: Colors.white,
          ),
        ],
        
      ),
    );
  }
}