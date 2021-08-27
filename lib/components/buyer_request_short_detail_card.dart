import 'package:aswanna_application/models/buyer_request.dart';
import 'package:aswanna_application/services/database/buyer_request_database_service.dart';
import 'package:aswanna_application/services/database/user_database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../constrants.dart';
import '../size_cofig.dart';

class BuyerRequestShortDetailCard extends StatelessWidget {
  final String buyerRequestID;
  final VoidCallback onPressed;
  const BuyerRequestShortDetailCard({
    Key key,
    @required this.buyerRequestID,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: FutureBuilder<BuyerRequest>(
        future:
            BuyerRequestDatabaseSerivce().getBuyerRequestWithID(buyerRequestID),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final buyerRequest = snapshot.data;
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(5), vertical: getProportionateScreenHeight(2)),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: cPrimaryColor.withOpacity(0.2)),
                  borderRadius: BorderRadius.all(
                    Radius.circular(14),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(width: getProportionateScreenWidth(20)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(10),
                                vertical: getProportionateScreenHeight(8)),
                            child: Text(
                              buyerRequest.title,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(40),
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF37474F),
                              ),
                              maxLines: 2,
                            ),
                          ),
                          // Text("${buyerRequest.description}"),

                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                getProportionateScreenWidth(10),
                                0,
                                0,
                                getProportionateScreenHeight(10)),
                            child: Text(
                              "Expected Quantity : ${buyerRequest.quantity.round()}KG",
                              style: TextStyle(
                                  fontSize: getProportionateScreenWidth(32),
                                  fontWeight: FontWeight.w600),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                getProportionateScreenWidth(10),
                                0,
                                0,
                                getProportionateScreenHeight(10)),
                            child: Text("${buyerRequest.listedDate}"),
                          )
                        ],
                      ),
                    ),
                    buildUserRoleBasedOfferButtn(context),
                  ],
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            final errorMessage = snapshot.error.toString();
            Logger().e(errorMessage);
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
    );
  }

  Widget buildUserRoleBasedOfferButtn(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: UserDatabaseService().currentUserDataStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            final error = snapshot.error;
            Logger().w(error.toString());
          }
          String userRole;
          if (snapshot.hasData && snapshot.data != null) {
            userRole = snapshot.data["role"];
          }
          if (userRole == "buyer") {
            return buildDisableOfferButton(context);
          }
          return buildOfferButton(context);
        });
  }

  Widget buildOfferButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, getProportionateScreenWidth(20), 0),
      child: TextButton.icon(
        onPressed: onPressed,
        label: Text("Send Offer"),
        icon: Icon(Icons.local_offer),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          side: MaterialStateProperty.all(
            BorderSide(
              color: Color(0xFF09af00),
              width: 2,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDisableOfferButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, getProportionateScreenWidth(20), 0),
      child: TextButton.icon(
        onPressed: null,
        label: Text("Send Offer"),
        icon: Icon(
          Icons.local_offer,
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          side: MaterialStateProperty.all(
            BorderSide(
              color: cTextColor,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
