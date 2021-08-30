
import 'package:aswanna_application/models/address.dart';
import 'package:aswanna_application/services/database/user_database_service.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../../constrants.dart';
import '../../../size_cofig.dart';

class AddressBox extends StatelessWidget {
  const AddressBox({
    Key key,
    @required this.addressId,
  }) : super(key: key);

  final String addressId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: FutureBuilder<Address>(
                  future: UserDatabaseService().getAddressFromId(addressId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final address = snapshot.data;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
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
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
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
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
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
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      final error = snapshot.error.toString();
                      Logger().e(error);
                    }
                    return Center(
                      child: Icon(
                        Icons.error,
                        color: cTextColor,
                        size: 60,
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
