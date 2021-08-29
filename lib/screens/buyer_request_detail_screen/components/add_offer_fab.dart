import 'package:aswanna_application/models/offer.dart';
import 'package:aswanna_application/services/auth/auth_service.dart';
import 'package:aswanna_application/services/database/buyer_request_database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'offer_view_section.dart';

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
        
                      String currentUserUid =
                          AuthService().currentUser.uid;
                      Offer prevOffer;
                      try {
                        prevOffer = await BuyerRequestDatabaseSerivce()
                            .getRequestOfferWithID(buyerRequestID, currentUserUid);
                      } on FirebaseException catch (e) {
                        Logger().w("Firebase Exception: $e");
                      } catch (e) {
                        Logger().w("Unknown Exception: $e");
                      } finally {
                        if (prevOffer == null) {
                          prevOffer = Offer(
                            currentUserUid,
                            sellerID: currentUserUid,
                          );
                        }
                      }

                      final result = await showDialog(
                        context: context,
                        builder: (context) {
                          return RequestOfferDialog(
                            offer: prevOffer,
                          );
                        },
                      );
                      if (result is Offer) {
                        bool reviewAdded = false;
                        String snackbarMessage;
                        try {
                          reviewAdded = await BuyerRequestDatabaseSerivce()
                              .addRequestOffer(buyerRequestID, result);
                          if (reviewAdded == true) {
                            snackbarMessage =
                                "Offer send successfully";
                          } else {
                            throw "Coulnd't send off due to unknown reason";
                          }
                        } on FirebaseException catch (e) {
                          Logger().w("Firebase Exception: $e");
                          snackbarMessage = e.toString();
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
                      // await refreshPage();
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