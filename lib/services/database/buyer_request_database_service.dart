import 'package:aswanna_application/models/buyer_request.dart';
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
    final docRef = await buyerRequestCollectionReference.add(buyerRequest.toMap());
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
}
