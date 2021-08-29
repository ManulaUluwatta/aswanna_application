import 'package:aswanna_application/models/offer.dart';
import 'package:aswanna_application/screens/profile_detail_screen/profile_detail_screen.dart';
import 'package:aswanna_application/services/database/user_database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constrants.dart';
import '../../../size_cofig.dart';

class OfferBox extends StatelessWidget {
  final Offer offer;
  const OfferBox({
    Key key,
    @required this.offer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
        vertical: getProportionateScreenHeight(20),
      ),
      // margin: EdgeInsets.symmetric(
      //   vertical: getProportionateScreenHeight(10),
      // ),
      decoration: BoxDecoration(
        color: cTextColor.withOpacity(0.075),
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  Text(
                    "Offered Price : ",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: cPrimaryColor,
                      fontSize: getProportionateScreenHeight(20),
                    ),
                  ),
                  Text(
                    "LKR ${offer.price.toString()}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: getProportionateScreenHeight(20),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                "Message : ",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: cPrimaryColor,
                  fontSize: getProportionateScreenHeight(20),
                ),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(5),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    offer.message,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(35),
                    ),
                  ),
                ),
                SizedBox(width: getProportionateScreenWidth(16)),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(5),
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                "Offer By : ",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: cPrimaryColor,
                  fontSize: getProportionateScreenHeight(20),
                ),
              ),
            ),
            SizedBox(width: double.infinity, child: getSellerDetails()),
          ],
        ),
      ),
    );
  }

  Widget getSellerDetails() {
    String sellerUID = offer.sellerID;
    return StreamBuilder<DocumentSnapshot>(
        stream: UserDatabaseService().getSellerDetails(sellerUID),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            final error = snapshot.error;
            Logger().w(error.toString());
          }
          String firstName;
          String lastName;
          String contact;
          if (snapshot.hasData && snapshot.data != null) {
            firstName = snapshot.data["firstName"];
            lastName = snapshot.data["lastName"];
            contact = snapshot.data["contact"];
          }
          return Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProfileDetailScreen(userID: sellerUID),
                      ));
                },
                child: Text.rich(
                  TextSpan(
                    // text: "Offer by ",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(35),
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: "$firstName $lastName",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(50),
              ),
              TextButton.icon(
                onPressed: () {
                  launch(('tel://$contact'));
                },
                icon: Icon(Icons.call),
                label: Text("$contact"),
                //  Icon(Icons.call,semanticLabel: contact,),
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
            ],
          );
        });
  }
}
