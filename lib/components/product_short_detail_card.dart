import 'package:aswanna_application/constrants.dart';
import 'package:aswanna_application/models/product.dart';
import 'package:aswanna_application/services/database/product_database_service.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../size_cofig.dart';

class ProductShortDetailCard extends StatelessWidget {
  final String productId;
  final VoidCallback onPressed;
  const ProductShortDetailCard({
    Key key,
    @required this.productId,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: FutureBuilder<Product>(
        future: ProductDatabaseService().getProductWithID(productId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final product = snapshot.data;
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: cPrimaryColor.withOpacity(0.2)),
                borderRadius: BorderRadius.all(
                  Radius.circular(14),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: getProportionateScreenWidth(200),
                    child: AspectRatio(
                      aspectRatio: 0.88,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: product.images.length > 0
                            ? Image.network(
                                product.images[0],
                                fit: BoxFit.contain,
                              )
                            : Text("No Image"),
                      ),
                    ),
                  ),
                  SizedBox(width: getProportionateScreenWidth(20)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(40),
                            fontWeight: FontWeight.bold,
                            color: cTextColor,
                          ),
                          maxLines: 2,
                        ),
                        SizedBox(height: 10),
                        Text.rich(
                          TextSpan(
                              text: "\LKR${product.discountPrice}    ",
                              style: TextStyle(
                                color: cPrimaryColor,
                                fontWeight: FontWeight.w700,
                                fontSize: getProportionateScreenWidth(35),
                              ),
                              children: [
                                TextSpan(
                                  text: "\LKR${product.originalPrice}",
                                  style: TextStyle(
                                    color: cTextColor,
                                    decoration: TextDecoration.lineThrough,
                                    fontWeight: FontWeight.normal,
                                    fontSize: getProportionateScreenWidth(30),
                                  ),
                                ),
                              ]),
                        ),
                        Text(
                            "Available Quantity : ${product.availableQuantity.round()}")
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            final errorMessage = snapshot.error.toString();
            Logger().e(errorMessage);
          }
          return Center(
            child: Icon(
              Icons.error,
              color: cTextColor,
              size: 60,
            ),
          );
        },
      ),
    );
  }
}
