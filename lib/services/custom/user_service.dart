import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseUser;
import '../../models/user.dart';


CollectionReference users = FirebaseFirestore.instance.collection('users');

class UserService{

   Future<User> create(User user) {
    firebaseUser.FirebaseAuth firebaseAuth = firebaseUser.FirebaseAuth.instance; // newly added.. change default doc id to user id
    String uid = firebaseAuth.currentUser.uid; // newly added.. change default doc id to user id
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(users.doc(uid));// newly added.. change default doc id to user id

      final Map<String, dynamic> data = user.toMap();

      tx.set(ds.reference, data);

      return data;
    };

    return FirebaseFirestore.instance
        .runTransaction(createTransaction)
        .then((value) => User.fromMap(value))
        .catchError((e) {
      print('error: $e');
      return e;
    });
  }

  Stream<QuerySnapshot> getAll({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = users.snapshots();

    if (offset != null) snapshots = snapshots.skip(offset);

    if (limit != null) snapshots = snapshots.take(limit);

    return snapshots;
  }

  Future<DocumentSnapshot> getById(String id) {
    return users.doc(id).get();
  
  }


}