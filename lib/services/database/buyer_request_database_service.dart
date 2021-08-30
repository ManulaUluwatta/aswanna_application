import 'package:aswanna_application/models/buyer_request.dart';
import 'package:aswanna_application/models/offer.dart';
import 'package:aswanna_application/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BuyerRequestDatabaseSerivce {
  static const String buyerRequestCollectionName = "buyerRequest";
  static const String offerCollectionName = "offer";

  BuyerRequestDatabaseSerivce._privateConstructor();
  static BuyerRequestDatabaseSerivce _instance =
      BuyerRequestDatabaseSerivce._privateConstructor();
  factory BuyerRequestDatabaseSerivce() {
    return _instance;
  }

  FirebaseFirestore _firebaseFirestore;
  FirebaseFirestore get firestore {
    if (_firebaseFirestore == null) {
      _firebaseFirestore = FirebaseFirestore.instance;
    }
    return _firebaseFirestore;
  }

  AuthService authService = AuthService();

  Future<String> addBuyerRequest(BuyerRequest buyerRequest) async {
    String uid = authService.currentUser.uid;
    buyerRequest.buyerId = uid;
    final buyerRequestCollectionReference =
        firestore.collection(buyerRequestCollectionName);
    final docRef =
        await buyerRequestCollectionReference.add(buyerRequest.toMap());
    return docRef.id;
  }

  Future<String> updateBuyerRequest(BuyerRequest buyerRequest) async {
    final buyerRequestMap = buyerRequest.toUpdateMap();
    final buyerRequestCollectionReference =
        firestore.collection(buyerRequestCollectionName);
    final docRef = buyerRequestCollectionReference.doc(buyerRequest.id);
    await docRef.update(buyerRequestMap);
    return docRef.id;
  }

  Future<List<dynamic>> get usersBuyerRequestList async {
    String uid = authService.currentUser.uid;
    final buyerRequestCollectionReference =
        firestore.collection(buyerRequestCollectionName);
    final querySnapshot = await buyerRequestCollectionReference
        .where("buyerID", isEqualTo: uid)
        .get();
    List usersBuyerRequest = <String>[];
    querySnapshot.docs.forEach((doc) {
      usersBuyerRequest.add(doc.id);
    });
    return usersBuyerRequest;
  }

  Future<bool> deleteBuyerRequest(String buyerRequestID) async {
    final buyerRequestCollectionReference =
        firestore.collection(buyerRequestCollectionName);
    await buyerRequestCollectionReference.doc(buyerRequestID).delete();
    return true;
  }

  Future<BuyerRequest> getBuyerRequestWithID(String buyerRequestID) async {
    final docSnapshot = await firestore
        .collection(buyerRequestCollectionName)
        .doc(buyerRequestID)
        .get();

    if (docSnapshot.exists) {
      return BuyerRequest.fromMap(docSnapshot.data(), id: docSnapshot.id);
    }
    return null;
  }

  Future<List<dynamic>> get allBuyerRequestList async {
    final buyerRequest =
        await firestore.collection(buyerRequestCollectionName).get();
    List buyerRequestID = <String>[];
    for (final buyerRequest in buyerRequest.docs) {
      final id = buyerRequest.id;
      buyerRequestID.add(id);
    }
    return buyerRequestID;
  }

  Future<bool> addRequestOffer(String requestId, Offer offer) async {
    final offersCollectionRef = firestore
        .collection(buyerRequestCollectionName)
        .doc(requestId)
        .collection(offerCollectionName);
    final offerDoc = offersCollectionRef.doc(offer.sellerID);
    if ((await offerDoc.get()).exists == false) {
      offerDoc.set(offer.toMap());
      return true;
    }
    return true;
  }


  Future<Offer> getRequestOfferWithID(String requestID, String sellerID) async {
    final offersCollectionRef = firestore
        .collection(buyerRequestCollectionName)
        .doc(requestID)
        .collection(offerCollectionName);
    final reviewDoc = await offersCollectionRef.doc(sellerID).get();
    if (reviewDoc.exists) {
      return Offer.fromMap(reviewDoc.data(), id: reviewDoc.id);
    }
    return null;
  }

  Stream<List<Offer>> getAllOfferStreamForRequestId(String requestId) async* {
    final offersQuerySnapshot = firestore
        .collection(buyerRequestCollectionName)
        .doc(requestId)
        .collection(offerCollectionName)
        .get()
        .asStream();
    await for (final querySnapshot in offersQuerySnapshot) {
      List<Offer> offers = <Offer>[];
      for (final offerDoc in querySnapshot.docs) {
        Offer offer = Offer.fromMap(offerDoc.data(), id: offerDoc.id);
        offers.add(offer);
      }
      yield offers;
    }
  }
}
