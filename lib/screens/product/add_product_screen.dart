import 'package:aswanna_application/models/product.dart';
// import 'package:aswanna_application/screens/complete_profile/components/body.dart';
import 'package:aswanna_application/screens/product/components/body.dart';
import 'package:aswanna_application/screens/product/provider_models/product_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../size_cofig.dart';

class AddProductScreen extends StatelessWidget {
  final Product? productToEdit;
  const AddProductScreen({ Key? key, this.productToEdit }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ChangeNotifierProvider(
      create: (context) => ProductDetails(),
      child: Scaffold(
        appBar: AppBar(title: Text("Add Product Details"),),
        body: Body(
            productToEdit:productToEdit,
          ),
      ),
      );
  }
}