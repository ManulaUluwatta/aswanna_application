
import 'package:aswanna_application/components/confirm_dialog.dart';
import 'package:aswanna_application/models/product.dart';
import 'package:aswanna_application/services/auth/auth_service.dart';
import 'package:aswanna_application/services/data_streem/cart_items_stream.dart';
import 'package:aswanna_application/services/database/product_database_service.dart';
import 'package:aswanna_application/services/database/user_database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:logger/logger.dart';


class AddToCartFAB extends StatefulWidget {
  const AddToCartFAB({
    Key key,
    @required this.productId,
  }) : super(key: key);

  final String productId;

  @override
  _AddToCartFABState createState() => _AddToCartFABState();
}

class _AddToCartFABState extends State<AddToCartFAB> {
  
   final CartItemsStream cartItemsStream = CartItemsStream();

   @override
  void initState() {
    cartItemsStream.init();
    super.initState();
  }

  @override
  void dispose() {
    cartItemsStream.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () async {
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
        // FutureBuilder<Product>(
        //     future: ProductDatabaseService().getProductWithID(productId),
        //     builder: (context, snapshot) {
        //       if (snapshot.hasData) {
        //         final Product product = snapshot.data;
        //         return buildProductCardItems(product);
        //       } else if (snapshot.connectionState == ConnectionState.waiting) {
        //         return Center(
        //           child: Center(child: CircularProgressIndicator()),
        //         );
        //       } else if (snapshot.hasError) {
        //         final error = snapshot.error.toString();
        //         Logger().e(error);
        //       }),
        Product product =await ProductDatabaseService().getProductWithID(widget.productId);
        int minQuantity = product.minQuantity.toInt();
        bool addedSuccessfully = false;
        String snackbarMessage;
        try {
          refreshPage();
          addedSuccessfully =
              await UserDatabaseService().addProductToCart(widget.productId,minQuantity);
          if (addedSuccessfully == true) {
            snackbarMessage = "Product added successfully";
          } else {
            throw "Coulnd't add product due to unknown reason";
          }
        } on FirebaseException catch (e) {
          Logger().w("Firebase Exception: $e");
          snackbarMessage = "Something went wrong";
        } catch (e) {
          Logger().w("Unknown Exception: $e");
          snackbarMessage = "Something went wrong";
        } finally {
          Logger().i(snackbarMessage);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(snackbarMessage),
            ),
          );
        }
      },
      label: Text(
        "Add to Cart",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      icon: Icon(
        Icons.shopping_cart,
      ),
    );
  }

  Future<void> refreshPage() {
    cartItemsStream.reload();
    return Future<void>.value();
  }
}
