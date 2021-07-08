import 'package:aswanna_application/models/product.dart';
import 'package:flutter/material.dart';

import '../constrants.dart';
import '../size_cofig.dart';

class ProductsCard extends StatelessWidget {
  const ProductsCard({
    Key? key,
    this.width = 100,
    this.aspectRa = 1.02,
    required this.product,
  }) : super(key: key);
  final double width, aspectRa;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: getProportionateScreenWidth(20),
      ),
      child: SizedBox(
        width: getProportionateScreenWidth(width),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: aspectRa,
              child: Container(
                padding: EdgeInsets.all(
                  getProportionateScreenWidth(20),
                ),
                decoration: BoxDecoration(
                  color: cSecondaryColor.withOpacity(8.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.asset(product.images[0]),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              product.title,
              style: TextStyle(color: Colors.black),
              maxLines: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${product.price}",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(18),
                    fontWeight: FontWeight.w600,
                    color: cPrimaryColor,
                  ),
                ),
              ],
            ),
            InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: (){},
              child: Container(
                padding: EdgeInsets.all(
                  getProportionateScreenWidth(8),
                ),
                width: getProportionateScreenWidth(28),
                height: getProportionateScreenWidth(28),
                decoration: BoxDecoration(
                  color:product.isFavourite 
                  ?cSecondaryColor.withOpacity(0.15)
                  :cSecondaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.favorite,
                color: product.isFavourite
                ?Color(0xFFFF4848)
                :Color(0xFFDBDEE4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
