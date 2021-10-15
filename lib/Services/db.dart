import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // collection reference
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('users');

  Future<void> updateUserData(String email, String name) async {
    return await collection.doc(uid).set({
      'email': email,
      'name': name,
    });
  }

  // Future<void> storeUserData(
  //     String name, String quant, String cost, String sale, String time) async {
  //   return await collection.document(uid).collection("Products").add({
  //     'Name': name,
  //     'Quantity': quant,
  //     'Cost': cost,
  //     'Sale': sale,
  //     'TimeStamp': time,
  //   });
  // }

  // List<UserDetails> detailsFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.documents.map((doc) {
  //     //print(doc.data);
  //     return UserDetails(
  //         id: doc.data['id'] ?? 0,
  //         date: doc.data['date'] ?? '0',
  //         time: doc.data['time'] ?? '0',
  //         people: doc.data['people'] ?? 0);
  //   }).toList();
  // }

  // // get brews stream
  // Stream<List<UserDetails>> get users {
  //   return collection
  //       .document(uid)
  //       .collection('Products')
  //       .snapshots()
  //       .map(detailsFromSnapshot);
  // }
}
