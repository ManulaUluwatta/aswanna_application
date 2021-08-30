import 'package:aswanna_application/constrants.dart';
import 'package:aswanna_application/models/review.dart';
import 'package:aswanna_application/screens/profile_detail_screen/profile_detail_screen.dart';
import 'package:aswanna_application/services/database/user_database_service.dart';
import 'package:aswanna_application/size_cofig.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

class ReviewBox extends StatelessWidget {
  final Review review;
  const ReviewBox({
    Key key,
    @required this.review,
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
      
      child: Column(
        children: [
          SizedBox(
            child: getSellerDetails(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  review.feedback,
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
                    "${review.rating}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getSellerDetails() {
    String reviewerID = review.reviewerUid;
    return StreamBuilder<DocumentSnapshot>(
        stream: UserDatabaseService().getSellerDetails(reviewerID),
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
                            ProfileDetailScreen(userID: reviewerID),
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
                          color: cPrimaryColor,
                          fontSize: getProportionateScreenHeight(17)
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(50),
              ),
              // TextButton.icon(
              //   onPressed: () {
              //     launch(('tel://$contact'));
              //   },
              //   icon: Icon(Icons.call),
              //   label: Text("$contact"),
              //   //  Icon(Icons.call,semanticLabel: contact,),
              //   style: ButtonStyle(
              //     shape: MaterialStateProperty.all(
              //       RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10.0),
              //       ),
              //     ),
              //     side: MaterialStateProperty.all(
              //       BorderSide(
              //         color: Color(0xFF09af00),
              //         width: 2,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          );
        });
  }
}
