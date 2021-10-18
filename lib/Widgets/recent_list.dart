import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mediumreplica/Models/articles.dart';

import '../constants.dart';

class RecentList extends StatefulWidget {
  const RecentList({Key? key}) : super(key: key);

  @override
  _RecentListState createState() => _RecentListState();
}

class _RecentListState extends State<RecentList> {
  final auth = FirebaseAuth.instance;
  String? uidUser = FirebaseAuth.instance.currentUser?.uid;

  final CollectionReference collection =
      FirebaseFirestore.instance.collection('users');
  int index = 0;

  List<Recent> recentList = [];

  @override
  void initState() {
    super.initState();
    recentList.clear();
    collection.doc(uidUser).collection('Recent').get().then((snapshot) {
      for (DocumentSnapshot doc1 in snapshot.docs) {
        doc1.reference.get();

        collection.doc(uidUser).collection('Articles').get().then((snapshot) {
          for (DocumentSnapshot doc2 in snapshot.docs) {
            if (doc1.id == doc2.id) {
              doc2.reference.get();

              Recent list = Recent(
                dp: doc2.get('dp'),
                author: doc2.get('author'),
                article: doc2.get('article'),
                img: doc2.get('img'),
                like: doc2.get('likes'),
                title: doc2.get('title'),
                uid: doc2.get('uid'),
                doc: doc2,
              );

              recentList.add(list);
              setState(() {});
            }
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: recentList.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: recentList.length,
              itemBuilder: (_, index) {
                return StackArticle(
                  doc: recentList[index].doc,
                  logo: recentList[index].dp,
                  article: recentList[index].article,
                  author: recentList[index].author,
                  uid: recentList[index].uid,
                  title: recentList[index].title,
                  img: recentList[index].img,
                  like: recentList[index].like,
                );
              }),
    );
  }
}
