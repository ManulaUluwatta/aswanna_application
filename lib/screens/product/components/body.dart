
import 'package:aswanna_application/models/product.dart';
import 'package:flutter/material.dart';

import '../../../size_cofig.dart';
import 'add_product_form.dart';

class Body extends StatelessWidget {
  final Product productToEdit;
  const Body({Key key, this.productToEdit}) : super(key: key);

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
                Text(
                  "Fill Product Details",
                  style: TextStyle(),
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                EditProductForm(product: productToEdit),
                SizedBox(height: getProportionateScreenHeight(30)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
