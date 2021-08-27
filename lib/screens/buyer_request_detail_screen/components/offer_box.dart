import 'package:aswanna_application/models/offer.dart';
import 'package:flutter/material.dart';

import '../../../constrants.dart';
import '../../../size_cofig.dart';

class OfferBox extends StatelessWidget {
  final Offer offer;
  const OfferBox({
    Key key,
    @required this.offer
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      margin: EdgeInsets.symmetric(
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: cTextColor.withOpacity(0.075),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              // offer.feedback,
              "",
              style: TextStyle(
                color: Colors.black,
                fontSize: getProportionateScreenWidth(35),
              ),
            ),
          ),
          SizedBox(width: 16),
          Column(
            children: [
              Icon(
                Icons.star,
                color: Colors.amber,
              ),
              Text(
                // "${review.rating}",
                "",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
