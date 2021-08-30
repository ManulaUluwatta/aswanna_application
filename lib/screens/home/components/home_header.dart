import 'package:aswanna_application/screens/home/components/body.dart';
import 'package:aswanna_application/screens/search_result/search_result_screen.dart';
import 'package:aswanna_application/services/custom/user_service.dart';
import 'package:aswanna_application/services/data_streem/all_products_stream.dart';
import 'package:aswanna_application/services/data_streem/cart_items_stream.dart';
import 'package:aswanna_application/services/database/product_database_service.dart';
import 'package:aswanna_application/services/database/user_database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../../size_cofig.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatefulWidget {
  final Function onCartButtonPress;
  final int itemCounter;
  const HomeHeader({
    Key key,@required this.onCartButtonPress, @required this.itemCounter,
  }) : super(key: key);

  @override
  _HomeHeaderState createState() => _HomeHeaderState(onCartButtonPress: onCartButtonPress, itemCounter: itemCounter);
}

class _HomeHeaderState extends State<HomeHeader> {
  final AllProductsStream allProductsStream = AllProductsStream();
   final CartItemsStream cartItemsStream = CartItemsStream();
  final Function onCartButtonPress;
  final int itemCounter;
  _HomeHeaderState({@required this.onCartButtonPress, @required this.itemCounter});
  
  @override
  void initState() {
    allProductsStream.init();
    cartItemsStream.init();
    super.initState();
  }
  @override
  void dispose() {
    allProductsStream.dispose();
    cartItemsStream.dispose();
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
          buildShopingCart(onCartButtonPress, itemCounter),
          
          IconBtnWithCounter(
            iconSrc: Icons.notifications,
            numOfItems: 0, //pass the related value
            press: () {}, //assign the behaviour
          ),
        ],
      ),
    );
  }

  Widget buildShopingCart(Function onCartButtonPress, int itemCounter){
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
            // return IconBtnWithCounter(
            // iconSrc: Icons.shopping_cart,
            // press: onCartButtonPress,//assign the behaviour
            // print("buyte counter $itemCounter");
            return buildCartItemCounter(itemCounter);
          }
          return SizedBox();
        }
    );
  }

  Future<void> refreshPage() {
    // favouriteProductsStream.reload();
    allProductsStream.reload();
    cartItemsStream.reload();
    return Future<void>.value();
  }

  Widget buildCartItemCounter(int itemCounter) {
    return StreamBuilder<List<String>>(
      stream: cartItemsStream.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<String> cartItemsId = snapshot.data;
          if (cartItemsId.length == 0) {
            return IconBtnWithCounter(
            iconSrc: Icons.shopping_cart,
            numOfItems: 0,
            press: onCartButtonPress,);
            
          }
          return IconBtnWithCounter(
            iconSrc: Icons.shopping_cart,
            numOfItems: itemCounter,
            press: onCartButtonPress,);
        }
        return SizedBox();
      }  
    );
  }
}
