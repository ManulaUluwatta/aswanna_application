import 'package:aswanna_application/models/CartItem.dart';
import 'package:aswanna_application/models/OrderedProduct.dart';
import 'package:aswanna_application/models/address.dart';
import 'package:aswanna_application/models/user.dart';
import 'package:aswanna_application/services/auth/auth_service.dart';
import 'package:aswanna_application/services/database/product_database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDatabaseService{
  static const String USERS_COLLECTION_NAME = "users";
  static const String ADDRESSES_COLLECTION_NAME = "address";
  static const String CART_COLLECTION_NAME = "cart";
  static const String ORDERED_PRODUCTS_COLLECTION_NAME = "ordered_products";

  static const String PHONE_KEY = 'contact';
  static const String DP_KEY = "display_picture";
  static const String FAV_PRODUCTS_KEY = "favourite_products";
  static const String USER_ROLE = "role";

  UserDatabaseService._privateConstructor();
  static UserDatabaseService _instance =
      UserDatabaseService._privateConstructor();
  factory UserDatabaseService() {
    return _instance;
  }
  FirebaseFirestore _firebaseFirestore;
  FirebaseFirestore get firestore {
    if (_firebaseFirestore == null) {
      _firebaseFirestore = FirebaseFirestore.instance;
    }
    return _firebaseFirestore;
  }

  // Future<void> createNewUser(String uid) async {
  //   await firestore.collection(USERS_COLLECTION_NAME).doc(uid).set({
  //     DP_KEY: null,
  //     PHONE_KEY: null,
  //     FAV_PRODUCTS_KEY: <String>[],
  //   });
  // }
  Future<String> updateUser(User user) async {
    final userMap = user.toUpdateMap();
    final userCollectionReference =
        firestore.collection("users");
    final docRef = userCollectionReference.doc(user.uid);
    await docRef.update(userMap);
    return docRef.id;
  }

  Future<void> deleteCurrentUserData() async {
    final uid = AuthService().currentUser.uid;
    final docRef = firestore.collection(USERS_COLLECTION_NAME).doc(uid);
    final cartCollectionRef = docRef.collection(CART_COLLECTION_NAME);
    final addressCollectionRef = docRef.collection(ADDRESSES_COLLECTION_NAME);
    final ordersCollectionRef =
        docRef.collection(ORDERED_PRODUCTS_COLLECTION_NAME);

    final cartDocs = await cartCollectionRef.get();
    for (final cartDoc in cartDocs.docs) {
      await cartCollectionRef.doc(cartDoc.id).delete();
    }
    final addressesDocs = await addressCollectionRef.get();
    for (final addressDoc in addressesDocs.docs) {
      await addressCollectionRef.doc(addressDoc.id).delete();
    }
    final ordersDoc = await ordersCollectionRef.get();
    for (final orderDoc in ordersDoc.docs) {
      await ordersCollectionRef.doc(orderDoc.id).delete();
    }

    await docRef.delete();
  }

  Future<bool> isProductFavourite(String productId) async {
    String uid = AuthService().currentUser.uid;
    final userDocSnapshot =
        firestore.collection(USERS_COLLECTION_NAME).doc(uid);
    final userDocData = (await userDocSnapshot.get()).data();
    final favList = userDocData[FAV_PRODUCTS_KEY].cast<String>();
    if (favList.contains(productId)) {
      return true;
    } else {
      return false;
    }
  }

  Future<List> get usersFavouriteProductsList async {
    String uid = AuthService().currentUser.uid;
    final userDocSnapshot =
        firestore.collection(USERS_COLLECTION_NAME).doc(uid);
    final userDocData = (await userDocSnapshot.get()).data();
    final favList = userDocData[FAV_PRODUCTS_KEY];
    return favList;
  }

  Future<bool> switchProductFavouriteStatus(
      String productId, bool newState) async {
    String uid = AuthService().currentUser.uid;
    final userDocSnapshot =
        firestore.collection(USERS_COLLECTION_NAME).doc(uid);

    if (newState == true) {
      userDocSnapshot.update({
        FAV_PRODUCTS_KEY: FieldValue.arrayUnion([productId])
      });
    } else {
      userDocSnapshot.update({
        FAV_PRODUCTS_KEY: FieldValue.arrayRemove([productId])
      });
    }
    return true;
  }

  Future<List<String>> get addressesList async {
    String uid = AuthService().currentUser.uid;
    final snapshot = await firestore
        .collection(USERS_COLLECTION_NAME)
        .doc(uid)
        .collection(ADDRESSES_COLLECTION_NAME)
        .get();
    final addresses = <String>[];
    snapshot.docs.forEach((doc) {
      addresses.add(doc.id);
    });

    return addresses;
  }

  Future<List<String>> getCurrentUserAddressID(String userID) async {
    // String uid = AuthService().currentUser.uid;
    final snapshot = await firestore
        .collection(USERS_COLLECTION_NAME)
        .doc(userID)
        .collection(ADDRESSES_COLLECTION_NAME)
        .get();
    final addresses = <String>[];
    snapshot.docs.forEach((doc) {
      addresses.add(doc.id);
    });

    return addresses;
  }

  Future<Address> getAddressFromId(String id) async {
    String uid = AuthService().currentUser.uid;
    final doc = await firestore
        .collection(USERS_COLLECTION_NAME)
        .doc(uid)
        .collection(ADDRESSES_COLLECTION_NAME)
        .doc(id)
        .get();
    final address = Address.fromMap(doc.data(), id: doc.id);
    return address;
  }
  Future<Address> getAddressCurrentUser(String userID, String addressID) async {
    String uid = AuthService().currentUser.uid;
    final doc = await firestore
        .collection(USERS_COLLECTION_NAME)
        .doc(userID)
        .collection(ADDRESSES_COLLECTION_NAME)
        .doc(addressID)
        .get();
    final address = Address.fromMap(doc.data(), id: doc.id);
    return address;
  }

  Future<bool> addAddressForCurrentUser(Address address) async {
    String uid = AuthService().currentUser.uid;
    final addressesCollectionReference = firestore
        .collection(USERS_COLLECTION_NAME)
        .doc(uid)
        .collection(ADDRESSES_COLLECTION_NAME);
    await addressesCollectionReference.add(address.toMap());
    return true;
  }

  Future<bool> deleteAddressForCurrentUser(String id) async {
    String uid = AuthService().currentUser.uid;
    final addressDocReference = firestore
        .collection(USERS_COLLECTION_NAME)
        .doc(uid)
        .collection(ADDRESSES_COLLECTION_NAME)
        .doc(id);
    await addressDocReference.delete();
    return true;
  }

  Future<bool> updateAddressForCurrentUser(Address address) async {
    String uid = AuthService().currentUser.uid;
    final addressDocReference = firestore
        .collection(USERS_COLLECTION_NAME)
        .doc(uid)
        .collection(ADDRESSES_COLLECTION_NAME)
        .doc(address.id);
    await addressDocReference.update(address.toMap());
    return true;
  }

  Future<CartItem> getCartItemFromId(String id) async {
    String uid = AuthService().currentUser.uid;
    final cartCollectionRef = firestore
        .collection(USERS_COLLECTION_NAME)
        .doc(uid)
        .collection(CART_COLLECTION_NAME);
    final docRef = cartCollectionRef.doc(id);
    final docSnapshot = await docRef.get();
    final cartItem = CartItem.fromMap(docSnapshot.data(), id: docSnapshot.id);
    return cartItem;
  }

  Future<bool> addProductToCart(String productId, int minQuantity) async {
    String uid = AuthService().currentUser.uid;
    final cartCollectionRef = firestore
        .collection(USERS_COLLECTION_NAME)
        .doc(uid)
        .collection(CART_COLLECTION_NAME);
    final docRef = cartCollectionRef.doc(productId);
    final docSnapshot = await docRef.get();
    bool alreadyPresent = docSnapshot.exists;
    if (alreadyPresent == false) {
      // docRef.set(CartItem(itemCount: 1).toMap());
      docRef.set(CartItem(itemCount: minQuantity).toMap());
    } else {
      docRef.update({CartItem.ITEM_COUNT_KEY: FieldValue.increment(1)});
    }
    return true;
  }

  Future<List<String>> emptyCart() async {
    String uid = AuthService().currentUser.uid;
    final cartItems = await firestore
        .collection(USERS_COLLECTION_NAME)
        .doc(uid)
        .collection(CART_COLLECTION_NAME)
        .get();
    List orderedProductsUid = <String>[];
    for (final doc in cartItems.docs) {
      orderedProductsUid.add(doc.id);
      await doc.reference.delete();
    }
    return orderedProductsUid;
  }

  Future<num> get cartTotal async {
    String uid = AuthService().currentUser.uid;
    final cartItems = await firestore
        .collection(USERS_COLLECTION_NAME)
        .doc(uid)
        .collection(CART_COLLECTION_NAME)
        .get();
    num total = 0.0;
    for (final doc in cartItems.docs) {
      num itemsCount = doc.data()[CartItem.ITEM_COUNT_KEY];
      final product = await ProductDatabaseService().getProductWithID(doc.id);
      total += (itemsCount * product.discountPrice);
    }
    return total;
  }

  Future<bool> removeProductFromCart(String cartItemID) async {
    String uid = AuthService().currentUser.uid;
    final cartCollectionReference = firestore
        .collection(USERS_COLLECTION_NAME)
        .doc(uid)
        .collection(CART_COLLECTION_NAME);
    await cartCollectionReference.doc(cartItemID).delete();
    return true;
  }

  Future<bool> increaseCartItemCount(String cartItemID) async {
    String uid = AuthService().currentUser.uid;
    final cartCollectionRef = firestore
        .collection(USERS_COLLECTION_NAME)
        .doc(uid)
        .collection(CART_COLLECTION_NAME);
    final docRef = cartCollectionRef.doc(cartItemID);
    docRef.update({CartItem.ITEM_COUNT_KEY: FieldValue.increment(1)});
    return true;
  }

  Future<bool> decreaseCartItemCount(String cartItemID) async {
    String uid = AuthService().currentUser.uid;
    final cartCollectionRef = firestore
        .collection(USERS_COLLECTION_NAME)
        .doc(uid)
        .collection(CART_COLLECTION_NAME);
    final docRef = cartCollectionRef.doc(cartItemID);
    final docSnapshot = await docRef.get();
    int currentCount = docSnapshot.data()[CartItem.ITEM_COUNT_KEY];
    if (currentCount <= 1) {
      return removeProductFromCart(cartItemID);
    } else {
      docRef.update({CartItem.ITEM_COUNT_KEY: FieldValue.increment(-1)});
    }
    return true;
  }

  Future<List<String>> get allCartItemsList async {
    String uid = AuthService().currentUser.uid;
    final querySnapshot = await firestore
        .collection(USERS_COLLECTION_NAME)
        .doc(uid)
        .collection(CART_COLLECTION_NAME)
        .get();
    List itemsId = <String>[];
    for (final item in querySnapshot.docs) {
      itemsId.add(item.id);
    }
    return itemsId;
  }

  Future<List<String>> get orderedProductsList async {
    String uid = AuthService().currentUser.uid;
    final orderedProductsSnapshot = await firestore
        .collection(USERS_COLLECTION_NAME)
        .doc(uid)
        .collection(ORDERED_PRODUCTS_COLLECTION_NAME)
        .get();
    List orderedProductsId = <String>[];
    for (final doc in orderedProductsSnapshot.docs) {
      orderedProductsId.add(doc.id);
    }
    return orderedProductsId;
  }

  Future<bool> addToMyOrders(List<OrderedProduct> orders) async {
    String uid = AuthService().currentUser.uid;
    final orderedProductsCollectionRef = firestore
        .collection(USERS_COLLECTION_NAME)
        .doc(uid)
        .collection(ORDERED_PRODUCTS_COLLECTION_NAME);
    for (final order in orders) {
      await orderedProductsCollectionRef.add(order.toMap());
    }
    return true;
  }

  Future<OrderedProduct> getOrderedProductFromId(String id) async {
    String uid = AuthService().currentUser.uid;
    final doc = await firestore
        .collection(USERS_COLLECTION_NAME)
        .doc(uid)
        .collection(ORDERED_PRODUCTS_COLLECTION_NAME)
        .doc(id)
        .get();
    final orderedProduct = OrderedProduct.fromMap(doc.data(), id: doc.id);
    return orderedProduct;
  }

  Stream<DocumentSnapshot> get currentUserDataStream {
    String uid = AuthService().currentUser.uid;
    return firestore
        .collection(USERS_COLLECTION_NAME)
        .doc(uid)
        .get()
        .asStream();
  }

  Future<bool> updatePhoneForCurrentUser(String phone) async {
    String uid = AuthService().currentUser.uid;
    final userDocSnapshot =
        firestore.collection(USERS_COLLECTION_NAME).doc(uid);
    await userDocSnapshot.update({PHONE_KEY: phone});
    return true;
  }

  String getPathForCurrentUserDisplayPicture() {
    final String currentUserUid = AuthService().currentUser.uid;
    return "user/display_picture/$currentUserUid";
  }

  Future<bool> uploadDisplayPictureForCurrentUser(String url) async {
    String uid = AuthService().currentUser.uid;
    final userDocSnapshot =
        firestore.collection(USERS_COLLECTION_NAME).doc(uid);
    await userDocSnapshot.update(
      {DP_KEY: url},
    );
    return true;
  }

  Future<bool> removeDisplayPictureForCurrentUser() async {
    String uid = AuthService().currentUser.uid;
    final userDocSnapshot =
        firestore.collection(USERS_COLLECTION_NAME).doc(uid);
    await userDocSnapshot.update(
      {
        DP_KEY: FieldValue.delete(),
      },
    );
    return true;
  }

  Future<String> get displayPictureForCurrentUser async {
    String uid = AuthService().currentUser.uid;
    final userDocSnapshot =
        await firestore.collection(USERS_COLLECTION_NAME).doc(uid).get();
    return userDocSnapshot.data()[DP_KEY];
  }


  //custom method not sure
  // static String name;
  // static String contact;
  // Future<String> getProductOwner(String owner) async {
  //   final userDocSnapshot =
  //       firestore.collection("users").doc(owner);
  //   final userDocData = (await userDocSnapshot.get()).data();
  //   final firstName = userDocData["firstName"];
  //   final lastName = userDocData["lastName"];
  //   contact = userDocData["contact"];
  //   name= "$firstName $lastName";
  //   print(name);
  //   return name;
  // }

  Stream<DocumentSnapshot> getSellerDetails(String owner) {
    return firestore
        .collection(USERS_COLLECTION_NAME)
        .doc(owner)
        .get()
        .asStream();
  }
  

  
}