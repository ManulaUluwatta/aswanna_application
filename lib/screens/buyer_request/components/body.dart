import 'package:aswanna_application/models/buyer_request.dart';
import 'package:flutter/material.dart';

import '../../../size_cofig.dart';
import 'add_buyer_request_form.dart';

class Body extends StatelessWidget {
  final BuyerRequest buyerRequestToEdit;
  const Body({Key key, this.buyerRequestToEdit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(height: getProportionateScreenHeight(10)),
                AddProductForm(buyerRequest: buyerRequestToEdit),
                SizedBox(height: getProportionateScreenHeight(30)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
