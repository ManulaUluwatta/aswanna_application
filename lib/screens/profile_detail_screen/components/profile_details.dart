import 'package:aswanna_application/constrants.dart';
import 'package:aswanna_application/services/database/user_database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../size_cofig.dart';

class ProfileDetail extends StatelessWidget {
  final String userID;
  const ProfileDetail({
    Key key,
    @required this.userID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getSellerDetails(),
          ],
        ),
      ],
    );
  }

  Widget getSellerDetails() {
    String sellerUID = userID;
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
          String email;
          String address;
          if (snapshot.hasData && snapshot.data != null) {
            firstName = snapshot.data["firstName"];
            lastName = snapshot.data["lastName"];
            contact = snapshot.data["contact"];
            email = snapshot.data["email"];
            address = snapshot.data["address"];
          }
          // return Row(
          //   children: [
          //     // SizedBox(height: getProportionateScreenHeight(300),),
          //     Column(
          //       children: [
          //         Text.rich(
          //           TextSpan(
          //               text: "$firstName $lastName",
          //               style: TextStyle(
          //                 fontSize: getProportionateScreenWidth(50),
          //                 color: Color(0xFF37474F),
          //                 fontWeight: FontWeight.w600,
          //               ),
          //               children: [
          //                 TextSpan(
          //                   text: "\n$email ",
          //                   style: TextStyle(
          //                     fontWeight: FontWeight.normal,
          //                     fontSize: getProportionateScreenWidth(35),
          //                   ),
          //                 ),
          //               ]),
          //         ),

          //       ],
          //     ),
          //     SizedBox(
          //       child: Container(
          //         color: Colors.amber,
          //       ),
          //     )
          //   ],
          // );
          return Container(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text.rich(
                    TextSpan(
                        text: "$firstName $lastName",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(50),
                          color: Color(0xFF37474F),
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text: "\n$email ",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: getProportionateScreenWidth(35),
                            ),
                          ),
                        ]),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Address",
                    style: TextStyle(
                        fontSize: getProportionateScreenWidth(35),
                        fontWeight: FontWeight.w500,
                        color: cPrimaryColor),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "$address",
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(10),),
                SizedBox(
                  width: double.infinity,
                  child: TextButton.icon(
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
                ),
              ],
            ),
          );
        });
  }
}
