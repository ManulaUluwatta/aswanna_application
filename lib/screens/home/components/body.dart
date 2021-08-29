import 'package:aswanna_application/components/confirm_dialog.dart';
import 'package:aswanna_application/screens/cart/cart_screen.dart';
import 'package:aswanna_application/screens/home/components/product_section.dart';
import 'package:aswanna_application/screens/product_details/product_details_screen.dart';
import 'package:aswanna_application/services/auth/auth_service.dart';
import 'package:aswanna_application/services/data_streem/all_products_stream.dart';
import 'package:aswanna_application/services/data_streem/cart_items_stream.dart';
import 'package:aswanna_application/services/data_streem/favourite_products_stream.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
// import 'package:aswanna_application/size_cofig.dart';
import '../../../size_cofig.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final FavouriteProductsStream favouriteProductsStream =
      FavouriteProductsStream();
  final AllProductsStream allProductsStream = AllProductsStream();

  final CartItemsStream cartItemsStream = CartItemsStream();

  static int itemCounter = 0;

  @override
  void initState() {
    super.initState();
    favouriteProductsStream.init();
    allProductsStream.init();
    cartItemsStream.init();
    refreshItemCounter();
  }

  @override
  void dispose() {
    favouriteProductsStream.dispose();
    allProductsStream.dispose();
    cartItemsStream.dispose();
    super.dispose();
  }

  void refreshItemCounter() {
    StreamBuilder<List<String>>(
        stream: cartItemsStream.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<String> cartItemsId = snapshot.data;
            if (cartItemsId.length == 0) {
              itemCounter = 0;
            }
            itemCounter = cartItemsId.length;
            print("item counter $itemCounter");
          }
          return null;
        });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: refreshPage,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: getProportionateScreenWidth(20),
              ),
              SizedBox(
                child: StreamBuilder<List<String>>(
                    stream: cartItemsStream.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<String> cartItemsId = snapshot.data;
                        if (cartItemsId.length == 0) {
                          itemCounter = 0;
                        }
                        itemCounter = cartItemsId.length;
                        print("item counter $itemCounter");
                      }
                      return SizedBox();
                    }),
              ),
              HomeHeader(
                itemCounter: itemCounter,
                onCartButtonPress: () async {
                  bool allowed = AuthService().currentUserVerified;
                  if (!allowed) {
                    final reverify = await showConfirmationDialog(context,
                        "You haven't verified your email address. This action is only allowed for verified users.",
                        positiveResponse: "Resend verification email",
                        negativeResponse: "Go back");
                    if (reverify) {
                      final future =
                          AuthService().sendEmailVerificationToUser();
                      await showDialog(
                        context: context,
                        builder: (context) {
                          return FutureProgressDialog(
                            future,
                            message: Text("Resending verification email"),
                          );
                        },
                      );
                    }
                    return;
                  }
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(),
                    ),
                  );
                  await refreshPage();
                },
              ),
              SizedBox(
                height: getProportionateScreenWidth(30),
              ),
              DiscountBanner(),
              SizedBox(
                height: getProportionateScreenWidth(30),
              ),
              Categories(),
              SizedBox(
                height: getProportionateScreenWidth(30),
              ),
              // SpecialOffers(),
              SizedBox(
                height: SizeConfig.screenHeight * 0.58,
                child: ProductSection(
                  sectionTitle: "Products You Like",
                  productsSteamController: favouriteProductsStream,
                  emptyMessage: "Add Product to Favourites",
                  onCardTap: onProductCardTapped,
                ),
              ),
              SizedBox(
                height: getProportionateScreenWidth(0),
              ),
              // PopularProduct(),
              SizedBox(
                height: SizeConfig.screenHeight * 0.85,
                child: ProductSection(
                  sectionTitle: "Explore All Products",
                  productsSteamController: allProductsStream,
                  emptyMessage: "Looks like all Stores are closed",
                  onCardTap: onProductCardTapped,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> refreshPage() {
    // favouriteProductsStream.reload();
    favouriteProductsStream.reload();
    allProductsStream.reload();
    cartItemsStream.reload();

    refreshItemCounter();
    return Future<void>.value();
  }

  void onProductCardTapped(String productId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(productId: productId),
      ),
    ).then((_) async {
      await refreshPage();
    });
  }
}
