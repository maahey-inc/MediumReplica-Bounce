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

//sav user data
  Future<DocumentReference<Map<String, dynamic>>> userProfile(
      String name, String bio, int followers, int following, String uid) async {
    return await collection.doc(uid).collection("Profile").add({
      'name': name,
      'bio': bio,
      'followers': followers,
      'following': following,
      'uid': uid,
    });
  }

//save articles
  Future<DocumentReference<Map<String, dynamic>>> storeArticle(String article,
      String time, String tags, int likes, String comments, String uid) async {
    return await collection.doc(uid).collection("Articles").add({
      'Article': article,
      'Tags': tags,
      'Likes': likes,
      'Comments': comments,
      'TimeStamp': time,
      'uid': uid,
    });
  }

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
