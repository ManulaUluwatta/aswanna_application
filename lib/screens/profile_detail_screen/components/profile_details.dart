import 'package:aswanna_application/constrants.dart';
import 'package:aswanna_application/models/address.dart';
import 'package:aswanna_application/services/database/user_database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../size_cofig.dart';

class ProfileDetail extends StatelessWidget {
  final String addressId;
  final String userID;
  const ProfileDetail({
    Key key,
    @required this.userID,
    @required this.addressId,
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
          // String address;
          if (snapshot.hasData && snapshot.data != null) {
            firstName = snapshot.data["firstName"];
            lastName = snapshot.data["lastName"];
            contact = snapshot.data["contact"];
            email = snapshot.data["email"];
            // address = snapshot.data["address"];
          }
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
                    "ADDRESS",
                    style: TextStyle(
                        fontSize: getProportionateScreenHeight(20),
                        fontWeight: FontWeight.w500,
                        color: cPrimaryColor),
                  ),
                ),
                // SizedBox(
                //   width: double.infinity,
                //   child: Text(
                //     "$address",
                //   ),
                // ),
                SizedBox(
                  width: double.infinity,
                  child: FutureBuilder<Address>(
                    future: UserDatabaseService()
                        .getAddressCurrentUser(userID, addressId),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final address = snapshot.data;
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                              child: SizedBox(
                                  width: double.infinity,
                                  child: SelectableText(
                                    "${address.addresLine1}",
                                    style: TextStyle(
                                        fontSize:
                                            getProportionateScreenHeight(20),
                                        fontWeight: FontWeight.w500),
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: SizedBox(
                                  width: double.infinity,
                                  child: SelectableText(
                                    "${address.addresLine2}",
                                    style: TextStyle(
                                        fontSize:
                                            getProportionateScreenHeight(20),
                                        fontWeight: FontWeight.w500),
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: SizedBox(
                                  width: double.infinity,
                                  child: SelectableText(
                                    "${address.city}",
                                    style: TextStyle(
                                        fontSize:
                                            getProportionateScreenHeight(20),
                                        fontWeight: FontWeight.w500),
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      Text(
                                        "POSTAL CODE : ",
                                        style: TextStyle(
                                            fontSize:getProportionateScreenHeight(20),
                                            fontWeight: FontWeight.w500,
                                            color: cPrimaryColor
                                            ),
                                      ),
                                      SelectableText(
                                        "${address.postalCode}",
                                        style: TextStyle(
                                            fontSize:
                                                getProportionateScreenHeight(
                                                    20),
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      Text(
                                        "DISTRICT : ",
                                        style: TextStyle(
                                            fontSize:getProportionateScreenHeight(20),
                                            fontWeight: FontWeight.w500,
                                            color: cPrimaryColor
                                            ),
                                      ),
                                      SelectableText(
                                        "${address.district}",
                                        style: TextStyle(
                                            fontSize:
                                                getProportionateScreenHeight(20),
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                              child: SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      Text(
                                        "PROVINCE : ",
                                        style: TextStyle(
                                            fontSize:getProportionateScreenHeight(20),
                                            fontWeight: FontWeight.w500,
                                            color: cPrimaryColor
                                            ),
                                      ),
                                      SelectableText(
                                        "${address.province}",
                                        style: TextStyle(
                                            fontSize:
                                                getProportionateScreenHeight(20),
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  )),
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        final error = snapshot.error.toString();
                        Logger().e(error);
                      }
                      return Center(
                        child: Icon(
                          Icons.error,
                          size: 40,
                          color: cTextColor,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(15),
                ),
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
