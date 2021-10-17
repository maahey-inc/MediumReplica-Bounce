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

//save user data
  Future<void> userProfile(String name, String bio, String dp, int followers,
      int following, String uid) async {
    return await collection.doc(uid).collection("Profile").doc(uid).set({
      'name': name,
      'bio': bio,
      'dp': dp,
      'followers': followers,
      'following': following,
      'uid': uid,
    });
  }

//save articles
  Future<DocumentReference<Map<String, dynamic>>> storeArticle(
      String article,
      String title,
      String time,
      List<dynamic> tags,
      int likes,
      String comments,
      String uid,
      String authorName,
      String dp) async {
    return await collection.doc(uid).collection("Articles").add({
      'article': article,
      'title': title,
      'tags': tags,
      'likes': likes,
      'comments': comments,
      'timeStamp': time,
      'uid': uid,
      'author': authorName,
      'dp': dp,
    });
  }

//get articles
  Future<Stream<Null>> getArticle(String article, String time, String tags,
      int likes, String comments, String uid) async {
    return collection
        .doc(uid)
        .collection("Articles")
        .snapshots()
        .map((data) {});
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
