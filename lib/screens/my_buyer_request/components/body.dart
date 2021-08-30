import 'package:aswanna_application/components/buyer_request_short_detail_card.dart';
import 'package:aswanna_application/components/confirm_dialog.dart';
import 'package:aswanna_application/components/nothing_to_show_container.dart';
import 'package:aswanna_application/constrants.dart';
import 'package:aswanna_application/models/buyer_request.dart';
import 'package:aswanna_application/screens/buyer_request/add_buyer_request_screen.dart';
import 'package:aswanna_application/screens/buyer_request_detail_screen/buyer_request_detail_screen.dart';
import 'package:aswanna_application/services/data_streem/users_buyer_request_stream.dart';
import 'package:aswanna_application/services/database/buyer_request_database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:logger/logger.dart';

import '../../../size_cofig.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final UsersBuyerRequestStream userBuyerRequestStream = UsersBuyerRequestStream();

  @override
  void initState() {
    super.initState();
    userBuyerRequestStream.init();
  }

  @override
  void dispose() {
    super.dispose();
    userBuyerRequestStream.dispose();
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
                  Text("Your Requests", style: Theme.of(context).textTheme.headline6),
                  SizedBox(height: getProportionateScreenHeight(10),),
                  Text(
                    "Swipe LEFT to Edit, Swipe RIGHT to Delete",
                    style: TextStyle(fontSize: getProportionateScreenWidth(30)),
                  ),
                  SizedBox(height: getProportionateScreenHeight(30)),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.7,
                    child: StreamBuilder<List<String>>(
                      stream: userBuyerRequestStream.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final productsIds = snapshot.data;
                          if (productsIds.length == 0) {
                            return Center(
                              child: NothingToShowContainer(
                                secondaryMessage:
                                    "Add your first request to find seller",
                              ),
                            );
                          }
                          return ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: productsIds.length,
                            itemBuilder: (context, index) {
                              return buildProductsCard(productsIds[index]);
                            },
                          );
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
                  SizedBox(height: getProportionateScreenHeight(60)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> refreshPage() {
    userBuyerRequestStream.reload();
    return Future<void>.value();
  }

  Widget buildProductsCard(String buyerRequestID) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: FutureBuilder<BuyerRequest>(
        future: BuyerRequestDatabaseSerivce().getBuyerRequestWithID(buyerRequestID),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final buyerRequest = snapshot.data;
            return buildProductDismissible(buyerRequest);
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
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
    );
  }

  Widget buildProductDismissible(BuyerRequest buyerRequest) {
    return Dismissible(
      key: Key(buyerRequest.id),
      direction: DismissDirection.horizontal,
      background: buildDismissibleSecondaryBackground(),
      secondaryBackground: buildDismissiblePrimaryBackground(),
      dismissThresholds: {
        DismissDirection.endToStart: 0.65,
        DismissDirection.startToEnd: 0.65,
      },
      child: BuyerRequestShortDetailCard(
        buyerRequestID: buyerRequest.id,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BuyerRequestDetailScreen(
                buyerRequestID: buyerRequest.id,
              ),
            ),
          );
        },
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          final confirmation = await showConfirmationDialog(
              context, "Are you sure to Delete Product?");
          if (confirmation) {
            
            bool productInfoDeleted = false;
            String snackbarMessage;
            try {
              final deleteProductFuture =
                  BuyerRequestDatabaseSerivce().deleteBuyerRequest(buyerRequest.id);
              productInfoDeleted = await showDialog(
                context: context,
                builder: (context) {
                  return FutureProgressDialog(
                    deleteProductFuture,
                    message: Text("Deleting Request"),
                  );
                },
              );
              if (productInfoDeleted == true) {
                snackbarMessage = "Request deleted successfully";
              } else {
                throw "Coulnd't delete request, please retry";
              }
            } on FirebaseException catch (e) {
              Logger().w("Firebase Exception: $e");
              snackbarMessage = "Something went wrong";
            } catch (e) {
              Logger().w("Unknown Exception: $e");
              snackbarMessage = e.toString();
            } finally {
              Logger().i(snackbarMessage);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(snackbarMessage),
                ),
              );
            }
          }
          await refreshPage();
          return confirmation;
        } else if (direction == DismissDirection.endToStart) {
          final confirmation = await showConfirmationDialog(
              context, "Are you sure to Edit Request?");
          if (confirmation) {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddBuyerRequestScreen(
                  buyerRequestToEdit: buyerRequest,
                ),
              ),
            );
          }
          // await refreshPage();
          return false;
        }
        return false;
      },
      onDismissed: (direction) async {
        await refreshPage();
      },
    );
  }

  Widget buildDismissiblePrimaryBackground() {
    return Container(
      padding: EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(
            Icons.edit,
            color: Colors.white,
          ),
          SizedBox(width: 4),
          Text(
            "Edit",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDismissibleSecondaryBackground() {
    return Container(
      padding: EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Delete",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          SizedBox(width: 4),
          Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
