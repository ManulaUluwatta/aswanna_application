import 'package:flutter/material.dart';

class SendOferFAB extends StatelessWidget {
  const SendOferFAB({
    Key key,
    @required this.buyerRequestID,
  }) : super(key: key);

  final String buyerRequestID;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () async {
        bool addedSuccessfully = false;
        String snackbarMessage;
        // try {
        //   addedSuccessfully =
        //       await UserDatabaseService().addProductToCart(productId);
        //   if (addedSuccessfully == true) {
        //     snackbarMessage = "Product added successfully";
        //   } else {
        //     throw "Coulnd't add product due to unknown reason";
        //   }
        // } on FirebaseException catch (e) {
        //   Logger().w("Firebase Exception: $e");
        //   snackbarMessage = "Something went wrong";
        // } catch (e) {
        //   Logger().w("Unknown Exception: $e");
        //   snackbarMessage = "Something went wrong";
        // } finally {
        //   Logger().i(snackbarMessage);
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(
        //       content: Text(snackbarMessage),
        //     ),
        //   );
        // }
      },
      label: Text(
        "Send offers",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      icon: Icon(
        Icons.local_offer,
      ),
    );
  }
}