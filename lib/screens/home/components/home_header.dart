import 'package:aswanna_application/screens/search_result/search_result_screen.dart';
import 'package:aswanna_application/services/custom/user_service.dart';
import 'package:aswanna_application/services/data_streem/all_products_stream.dart';
import 'package:aswanna_application/services/database/product_database_service.dart';
import 'package:aswanna_application/services/database/user_database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../../size_cofig.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({
    Key key,
  }) : super(key: key);

  @override
  _HomeHeaderState createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  final AllProductsStream allProductsStream = AllProductsStream();
  @override
  void initState() {
    allProductsStream.init();
    super.initState();
  }
  @override
  void dispose() {
    allProductsStream.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(
            onSubmit: (value) async {
                    final query = value.toString();
                    if (query.length <= 0) return;
                    List<String> searchedProductsId;
                    try {
                      searchedProductsId = await ProductDatabaseService()
                          .searchInProducts(query.toLowerCase());
                      if (searchedProductsId != null) {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchResultScreen(
                              searchQuery: query,
                              searchResultProductsId: searchedProductsId,
                              searchIn: "All Products",
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
          buildShopingCart(),
          
          IconBtnWithCounter(
            iconSrc: Icons.notifications,
            numOfItems: 4, //pass the related value
            press: () {}, //assign the behaviour
          ),
        ],
      ),
    );
  }

  Widget buildShopingCart(){
    return StreamBuilder<DocumentSnapshot>(
       stream: UserDatabaseService().currentUserDataStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            final error = snapshot.error;
            Logger().w(error.toString());
          }
          String userRole;
          if(snapshot.hasData && snapshot.data != null){
            userRole = snapshot.data["role"];
          }
          if(userRole == "Buyer"){
            return IconBtnWithCounter(
            iconSrc: Icons.shopping_cart,
            press: () {}, //assign the behaviour
          );
          }
          return SizedBox();
        }
    );
  }

  Future<void> refreshPage() {
    // favouriteProductsStream.reload();
    allProductsStream.reload();
    return Future<void>.value();
  }
}
