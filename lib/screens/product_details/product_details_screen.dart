import 'package:aswanna_application/screens/product_details/components/body.dart';
import 'package:flutter/material.dart';
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
        floatingActionButton: AddToCartFAB(productId: productId),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}