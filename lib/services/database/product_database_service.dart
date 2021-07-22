import 'package:aswanna_application/models/product.dart';
import 'package:aswanna_application/models/review.dart';
import 'package:aswanna_application/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enum_to_string/enum_to_string.dart';

class ProductDatabaseService{
  static const String productCollectionName = "products";
  static const String reviewCollectionName = "reviews";

  ProductDatabaseService._privateConstructor();
  static ProductDatabaseService _instance = ProductDatabaseService._privateConstructor();
  factory ProductDatabaseService(){
    return _instance;
  }

  FirebaseFirestore _firebaseFirestore;
  FirebaseFirestore get firestore{
    if (_firebaseFirestore == null) {
      _firebaseFirestore = FirebaseFirestore.instance;
    }
    return _firebaseFirestore;
  }

  AuthService authService = AuthService();

   Future<List<dynamic>> searchInProducts(String query,
      {ProductType productType}) async {
    Query queryRef;
    if (productType == null) {
      queryRef = firestore.collection(productCollectionName);
    } else {
      final productTypeStr = EnumToString.convertToString(productType);
      print(productTypeStr);
      queryRef = firestore
          .collection(productCollectionName)
          .where("product_type", isEqualTo: productTypeStr);
    }

    Set productsId = Set<String>();
    final querySearchInTags = await queryRef
        .where("search_tag", arrayContains: query)
        .get();
    for (final doc in querySearchInTags.docs) {
      productsId.add(doc.id);
    }
    final queryRefDocs = await queryRef.get();
    for (final doc in queryRefDocs.docs) {
      final product = Product.fromMap(doc.data() as Map<String,dynamic>, id: doc.id);

      if (product.title.toString().toLowerCase().contains(query) ||
          product.description.toString().toLowerCase().contains(query) ||
          product.highlights.toString().toLowerCase().contains(query) ||
          product.subCategory.toString().toLowerCase().contains(query) ||
          product.owner.toString().toLowerCase().contains(query)) {
        productsId.add(product.id);
      }
    }
    return productsId.toList();
  }

  Future<bool> addProductReview(String productId, Review review) async {
    final reviewesCollectionRef = firestore
        .collection(productCollectionName)
        .doc(productId)
        .collection(reviewCollectionName);
    final reviewDoc = reviewesCollectionRef.doc(review.reviewerUid);
    if ((await reviewDoc.get()).exists == false) {
      reviewDoc.set(review.toMap());
      return await addUsersRatingForProduct(
        productId,
        review.rating,
      );
    } else {
      int oldRating = 0;
      oldRating = (await reviewDoc.get()).data()["rating"];
      reviewDoc.update(review.toUpdateMap());
      return await addUsersRatingForProduct(productId, review.rating,
          oldRating: oldRating);
    }
  }

  Future<bool> addUsersRatingForProduct(String productId, int rating,
      {int oldRating}) async {
    final productDocRef =
        firestore.collection(productCollectionName).doc(productId);
    final ratingsCount =
        (await productDocRef.collection(reviewCollectionName).get())
            .docs
            .length;
    final productDoc = await productDocRef.get();
    final prevRating = productDoc.data()["rating"];
    double newRating;
    if (oldRating == null) {
      newRating = (prevRating * (ratingsCount - 1) + rating) / ratingsCount;
    } else {
      newRating =
          (prevRating * (ratingsCount) + rating - oldRating) / ratingsCount;
    }
    final newRatingRounded = double.parse(newRating.toStringAsFixed(1));
    await productDocRef.update({"rating": newRatingRounded});
    return true;
  }

  Future<Review> getProductReviewWithID(
      String productId, String reviewId) async {
    final reviewesCollectionRef = firestore
        .collection(productCollectionName)
        .doc(productId)
        .collection(reviewCollectionName);
    final reviewDoc = await reviewesCollectionRef.doc(reviewId).get();
    if (reviewDoc.exists) {
      return Review.fromMap(reviewDoc.data(), id: reviewDoc.id);
    }
    return null;
  }

  Stream<List<Review>> getAllReviewsStreamForProductId(
      String productId) async* {
    final reviewesQuerySnapshot = firestore
        .collection(productCollectionName)
        .doc(productId)
        .collection(reviewCollectionName)
        .get()
        .asStream();
    await for (final querySnapshot in reviewesQuerySnapshot) {
      List<Review> reviews = <Review>[];
      for (final reviewDoc in querySnapshot.docs) {
        Review review = Review.fromMap(reviewDoc.data(), id: reviewDoc.id);
        reviews.add(review);
      }
      yield reviews;
    }
  }

  Future<Product> getProductWithID(String productId) async {
    final docSnapshot = await firestore
        .collection(productCollectionName)
        .doc(productId)
        .get();

    if (docSnapshot.exists) {
      return Product.fromMap(docSnapshot.data(), id: docSnapshot.id);
    }
    return null;
  }

  Future<String> addUsersProduct(Product product) async {
    String uid = authService.currentUser.uid;
    final productMap = product.toMap();
    product.owner = uid;
    final productsCollectionReference =
        firestore.collection(productCollectionName);
    final docRef = await productsCollectionReference.add(product.toMap());
    await docRef.update({
      "search_tag": FieldValue.arrayUnion(
          [productMap["product_type"].toString().toLowerCase()])
    });
    return docRef.id;
  }

  Future<bool> deleteUserProduct(String productId) async {
    final productsCollectionReference =
        firestore.collection(productCollectionName);
    await productsCollectionReference.doc(productId).delete();
    return true;
  }

  Future<String> updateUsersProduct(Product product) async {
    final productMap = product.toUpdateMap();
    final productsCollectionReference =
        firestore.collection(productCollectionName);
    final docRef = productsCollectionReference.doc(product.id);
    await docRef.update(productMap);
    if (product.productType != null) {
      await docRef.update({
        "search_tag": FieldValue.arrayUnion(
            [productMap["product_type"].toString().toLowerCase()])
      });
    }
    return docRef.id;
  }

  Future<List<dynamic>> getCategoryProductsList(ProductType productType) async {
    final productsCollectionReference =
        firestore.collection(productCollectionName);
    final queryResult = await productsCollectionReference
        .where("product_type",
            isEqualTo: EnumToString.convertToString(productType))
        .get();
    List productsId = <String>[];
    for (final product in queryResult.docs) {
      final id = product.id;
      productsId.add(id);
    }
    return productsId;
  }

  Future<List<dynamic>> get usersProductsList async {
    String uid = authService.currentUser.uid;
    final productsCollectionReference =
        firestore.collection(productCollectionName);
    final querySnapshot = await productsCollectionReference
        .where("owner", isEqualTo: uid)
        .get();
    List usersProducts = <String>[];
    querySnapshot.docs.forEach((doc) {
      usersProducts.add(doc.id);
    });
    return usersProducts;
  }

  Future<List<dynamic>> get allProductsList async {
    final products = await firestore.collection(productCollectionName).get();
    List productsId = <String>[];
    for (final product in products.docs) {
      final id = product.id;
      productsId.add(id);
    }
    return productsId;
  }

  Future<bool> updateProductsImages(
      String productId, List<String> imgUrl) async {
    final Product updateProduct = Product(null,  images:imgUrl);
    final docRef =
        firestore.collection(productCollectionName).doc(productId);
    await docRef.update(updateProduct.toUpdateMap());
    return true;
  }

  String getPathForProductImage(String id, int index) {
    String path = "products/images/$id";
    return path + "_$index";
  }
}

