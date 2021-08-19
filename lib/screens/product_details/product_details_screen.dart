

import 'package:aswanna_application/screens/product_details/components/body.dart';
import 'package:aswanna_application/services/database/user_database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'components/fab.dart';
import 'provider_models/ProductActions.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String productId;

  const ProductDetailsScreen({
    Key key,
    @required this.productId,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      
      create: (context) => ProductActions(),
      child: Scaffold(
        backgroundColor: Color(0xFFF5F6F9),
        appBar: AppBar(
          backgroundColor: Color(0xFFF5F6F9),
        ),
        body: Body(
          productId: productId,
        ),
        floatingActionButton: buildUserDate(),
        // floatingActionButton: AddToCartFAB(productId: productId),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Widget buildUserDate(){
    return StreamBuilder<DocumentSnapshot>(
      stream: UserDatabaseService().currentUserDataStream,
      builder: (context,snapshot){
        if(snapshot.hasError){
          final error = snapshot.error;
          Logger().w(error.toString());
        }
        String userRole;
        if(snapshot.hasData && snapshot.data != null)
          userRole = snapshot.data[UserDatabaseService.USER_ROLE];
        if(userRole == "Buyer"){
          return AddToCartFAB(productId: productId);
        }
        return SizedBox();

      },
      );
  }
}