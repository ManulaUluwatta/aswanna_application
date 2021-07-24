import 'package:aswanna_application/constrants.dart';
import 'package:aswanna_application/models/product.dart';
import 'package:aswanna_application/services/database/product_database_service.dart';
import 'package:aswanna_application/size_cofig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';

class ProductsCard extends StatelessWidget {
  const ProductsCard({
    Key key,
    @required this.productId,
    @required this.press,
  }) : super(key: key);
  final String productId;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(2)),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: cTextColor.withOpacity(0.2)
              ),
            borderRadius: BorderRadius.all(
              Radius.circular(14),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: FutureBuilder<Product>(
              future: ProductDatabaseService().getProductWithID(productId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final Product product = snapshot.data;
                  return buildProductCardItems(product);
                } else if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Center(child: CircularProgressIndicator()),
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
              },
            ),
          ),
        ),
      ),
    );
  }

  Column buildProductCardItems(Product product) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(2),horizontal: getProportionateScreenWidth(2)),
            child: Image.network(
              product.images[0],
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(height: SizeConfig.screenHeight*0.01),
        Flexible(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: Text(
                  "${product.title}\n",
                  style: TextStyle(
                    color: cTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Flexible(
                flex: 1,
                child: Text(
                  "${product.subCategory}\n",
                  style: TextStyle(
                    color: cTextColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Flexible(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 4,
                      child: Text.rich(
                        TextSpan(
                          text: "LKR.${product.discountPrice}\n",
                          style: TextStyle(
                            color: cTextColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                          children: [
                            TextSpan(
                              text: "${product.originalPrice}",
                              style: TextStyle(
                                color: cTextColor,
                                decoration: TextDecoration.lineThrough,
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Stack(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/DiscountTag.svg",
                            color: Color(0xFF09af00),
                          ),
                          Center(
                            child: Text(
                              "${product.calculateDiscountPrice()}%\nOff",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: getProportionateScreenWidth(12),
                                fontWeight: FontWeight.w900,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
