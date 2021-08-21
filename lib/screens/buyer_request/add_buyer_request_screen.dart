import 'package:aswanna_application/models/buyer_request.dart';
import 'package:aswanna_application/screens/buyer_request/components/body.dart';
import 'package:aswanna_application/screens/buyer_request/provider_models/buyer_request_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../size_cofig.dart';

class AddBuyerRequestScreen extends StatelessWidget {
  final BuyerRequest buyerRequestToEdit;
  const AddBuyerRequestScreen({ Key key, this.buyerRequestToEdit }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ChangeNotifierProvider(
      create: (context) => BuyerRequestDetails(),
      child: Scaffold(
        appBar: AppBar(title: Text("Add Product Details"),),
        body: Body(
            buyerRequestToEdit:buyerRequestToEdit
          ),
      ),
      );
  }
}