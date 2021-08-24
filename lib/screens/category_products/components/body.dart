import 'package:aswanna_application/components/nothing_to_show_container.dart';
import 'package:aswanna_application/components/product_card.dart';
import 'package:aswanna_application/components/rounded_icon_button.dart';
import 'package:aswanna_application/models/product.dart';
import 'package:aswanna_application/screens/home/components/search_field.dart';
import 'package:aswanna_application/screens/product_details/product_details_screen.dart';
import 'package:aswanna_application/screens/search_result/search_result_screen.dart';
import 'package:aswanna_application/services/data_streem/category_products_stream.dart';
import 'package:aswanna_application/services/database/product_database_service.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';

import '../../../size_cofig.dart';

class Body extends StatefulWidget {
  final ProductType productType;

  Body({
    Key key,
    @required this.productType,
  }) : super(key: key);

  @override
  _BodyState createState() =>
      _BodyState(categoryProductsStream: CategoryProductsStream(productType));
}

class _BodyState extends State<Body> {
  final CategoryProductsStream categoryProductsStream;

  _BodyState({@required this.categoryProductsStream});

  @override
  void initState() {
    super.initState();
    categoryProductsStream.init();
  }

  @override
  void dispose() {
    super.dispose();
    categoryProductsStream.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: refreshPage,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(height: getProportionateScreenHeight(20)),
                  buildHeadBar(),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.13,
                    child: buildCategoryBanner(),
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.68,
                    child: StreamBuilder<List<String>>(
                      stream: categoryProductsStream.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<String> productsId = snapshot.data;
                          if (productsId.length == 0) {
                            return Center(
                              child: NothingToShowContainer(
                                iconPath: "assets/icons/empty_box.svg ",
                                secondaryMessage:
                                    "No Products in ${EnumToString.convertToString(widget.productType)}",
                              ),
                            );
                          }

                          return buildProductsGrid(productsId);
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          final error = snapshot.error;
                          Logger().w(error.toString());
                        }
                        return Center(
                          child: NothingToShowContainer(
                            iconPath: "assets/icons/network_error.svg",
                            primaryMessage: "Something went wrong",
                            secondaryMessage: "Unable to connect to Database",
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHeadBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RoundedIconButton(
          iconData: Icons.arrow_back_ios,
          press: () {
            Navigator.pop(context);
          },
        ),
        SizedBox(width: 5),
        Expanded(
          child: SearchField(
            onSubmit: (value) async {
              final query = value.toString();
              if (query.length <= 0) return;
              List<String> searchedProductsId;
              try {
                searchedProductsId = await ProductDatabaseService()
                    .searchInProducts(query.toLowerCase(),
                        productType: widget.productType);
                if (searchedProductsId != null) {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchResultScreen(
                        searchQuery: query,
                        searchResultProductsId: searchedProductsId,
                        searchIn:
                            EnumToString.convertToString(widget.productType),
                      ),
                    ),
                  );
                  await refreshPage();
                } else {
                  throw "Couldn't perform search due to some unknown reason";
                }
              } catch (e) {
                final error = e.toString();
                Logger().e(error);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("$error"),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Future<void> refreshPage() {
    categoryProductsStream.reload();
    return Future<void>.value();
  }

  Widget buildCategoryBanner() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(bannerFromProductType()),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Color(0xFF41c300),
                BlendMode.colorBurn,
              ),
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              EnumToString.convertToString(widget.productType),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: getProportionateScreenWidth(50),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildProductsGrid(List<String> productsId) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFF5F6F9),
        borderRadius: BorderRadius.circular(15),
      ),
      child: GridView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: productsId.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ProductsCard(
            productId: productsId[index],
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(
                    productId: productsId[index],
                  ),
                ),
              ).then(
                (_) async {
                  await refreshPage();
                },
              );
            },
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 2,
          mainAxisSpacing: 8,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 12,
        ),
      ),
    );
  }

  String bannerFromProductType() {
    switch (widget.productType) {
      case ProductType.FRUIT:
        return "assets/images/fruit.png";
      case ProductType.RICE:
        return "assets/images/rice.png";
      case ProductType.VEGITABLE:
        return "assets/images/vegi.png";
      default:
        return "assets/images/others_banner.jpg";
    }
  }
}
