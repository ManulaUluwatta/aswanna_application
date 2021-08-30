import 'package:aswanna_application/constrants.dart';
import 'package:aswanna_application/models/address.dart';
import 'package:aswanna_application/services/database/user_database_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../../size_cofig.dart';

class AddressShortDetailsCard extends StatelessWidget {
  final String addressId;
  final Function onTap;

  const AddressShortDetailsCard(
      {Key key, @required this.addressId, @required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        height: SizeConfig.screenHeight * 0.26,
        child: FutureBuilder<Address>(
          future: UserDatabaseService().getAddressFromId(addressId),
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
                              fontSize: getProportionateScreenHeight(20),
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
                              fontSize: getProportionateScreenHeight(20),
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
                              fontSize: getProportionateScreenHeight(20),
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                    child: SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Text(
                              "POSTAL CODE : ",
                              style: TextStyle(
                                  fontSize: getProportionateScreenHeight(20),
                                  fontWeight: FontWeight.w500,
                                  color: cPrimaryColor),
                            ),
                            SelectableText(
                              "${address.postalCode}",
                              style: TextStyle(
                                  fontSize: getProportionateScreenHeight(20),
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                    child: SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Text(
                              "DISTRICT : ",
                              style: TextStyle(
                                  fontSize: getProportionateScreenHeight(20),
                                  fontWeight: FontWeight.w500,
                                  color: cPrimaryColor),
                            ),
                            SelectableText(
                              "${address.district}",
                              style: TextStyle(
                                  fontSize: getProportionateScreenHeight(20),
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 5, 0, 10),
                    child: SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Text(
                              "PROVINCE : ",
                              style: TextStyle(
                                  fontSize: getProportionateScreenHeight(20),
                                  fontWeight: FontWeight.w500,
                                  color: cPrimaryColor),
                            ),
                            SelectableText(
                              "${address.province}",
                              style: TextStyle(
                                  fontSize: getProportionateScreenHeight(20),
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

              // return Row(
              //   children: [
              //     Expanded(
              //       flex: 3,
              //       child: Container(
              //         height: double.infinity,
              //         padding:
              //             EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(8), vertical: getProportionateScreenHeight(10)),
              //         decoration: BoxDecoration(
              //           color: cTextColor.withOpacity(0.24),
              //           borderRadius: BorderRadius.only(
              //             topLeft: Radius.circular(15),
              //             bottomLeft: Radius.circular(15),
              //           ),
              //         ),
              //         child: Center(
              //           child: Text(
              //             address.title,
              //             style: TextStyle(
              //               color: Colors.black,
              //               fontSize: 18,
              //               fontWeight: FontWeight.w600,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //     Expanded(
              //       flex: 8,
              //       child: Container(
              //         padding: EdgeInsets.symmetric(
              //           horizontal: 8,
              //           vertical: 12,
              //         ),
              //         decoration: BoxDecoration(
              //           border: Border.all(color: kTextColor.withOpacity(0.24)),
              //           borderRadius: BorderRadius.only(
              //             topRight: Radius.circular(15),
              //             bottomRight: Radius.circular(15),
              //           ),
              //         ),
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             Text(
              //               address.receiver,
              //               style: TextStyle(
              //                 color: Colors.black,
              //                 fontWeight: FontWeight.bold,
              //                 fontSize: 15,
              //               ),
              //             ),
              //             Text("City: ${address.city}"),
              //             Text("Phone: ${address.phone}"),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ],
              // );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
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
    );
  }
}
