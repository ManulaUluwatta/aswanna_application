import 'package:aswanna_application/models/buyer_request.dart';
import 'package:aswanna_application/screens/profile_detail_screen/profile_detail_screen.dart';
import 'package:aswanna_application/services/database/user_database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../size_cofig.dart';
import 'expandable_text.dart';

class BuyerRequestDecription extends StatelessWidget {
  const BuyerRequestDecription({
    Key key,
    @required this.buyerRequest,
  }) : super(key: key);

  final BuyerRequest buyerRequest;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                text: buyerRequest.title,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(50),
                  color: Color(0xFF37474F),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 16),
            BuyerRequestExpandableText(
              title: "Description",
              content: buyerRequest.description,
            ),
            const SizedBox(height: 16),
            getBuyerDetails(),
          ],
        ),
      ],
    );
  }

  Widget getBuyerDetails() {
    String buyerUID = buyerRequest.buyerId;
    return StreamBuilder<DocumentSnapshot>(
        stream: UserDatabaseService().getSellerDetails(buyerUID),
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
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileDetailScreen(userID: buyerUID),
                    ));
                },
                child: Text.rich(
                  TextSpan(
                    text: "Request by ",
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
                width: 10,
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
