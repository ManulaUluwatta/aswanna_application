import 'package:aswanna_application/screens/buyer_request_detail_screen/components/add_offer_fab.dart';
import 'package:aswanna_application/screens/buyer_request_detail_screen/components/body.dart';
import 'package:aswanna_application/services/database/user_database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class BuyerRequestDetailScreen extends StatelessWidget {
  final String buyerRequestID;

  const BuyerRequestDetailScreen({
    Key key,
    @required this.buyerRequestID,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: AppBar(
        title: Text("Request Details"),
        // backgroundColor: Color(0xFFF5F6F9),
      ),
      body: Body(
        buyerRequestID: buyerRequestID,
      ),
      floatingActionButton: buildUserDate(),
      // floatingActionButton: AddToCartFAB(productId: productId),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget buildUserDate() {
    return StreamBuilder<DocumentSnapshot>(
      stream: UserDatabaseService().currentUserDataStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          final error = snapshot.error;
          Logger().w(error.toString());
        }
        String userRole;
        if (snapshot.hasData && snapshot.data != null)
          userRole = snapshot.data[UserDatabaseService.USER_ROLE];
        if (userRole == "Seller") {
          return SendOferFAB(buyerRequestID: buyerRequestID);
        }
        return SizedBox();
      },
    );
  }
}
