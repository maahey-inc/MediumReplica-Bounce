import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mediumreplica/Models/articles.dart';

import '../constants.dart';

class SavedList extends StatefulWidget {
  const SavedList({Key? key}) : super(key: key);

  @override
  _SavedListState createState() => _SavedListState();
}

class _SavedListState extends State<SavedList> {
  final auth = FirebaseAuth.instance;
  String? uidUser = FirebaseAuth.instance.currentUser?.uid;

  final CollectionReference collection =
      FirebaseFirestore.instance.collection('users');
  int index = 0;

  List<Data> dataList = [];

  @override
  void initState() {
    super.initState();
    dataList.clear();
    collection.doc(uidUser).collection('Lists').get().then((snapshot) {
      for (DocumentSnapshot doc1 in snapshot.docs) {
        doc1.reference.get();

        print(doc1.id);
        collection.doc(uidUser).collection('Articles').get().then((snapshot) {
          for (DocumentSnapshot doc2 in snapshot.docs) {
            if (doc1.id == doc2.id) {
              doc2.reference.get();

              print(doc2.id);

              Data list = Data(
                dp: doc2.get('dp'),
                author: doc2.get('author'),
                article: doc2.get('article'),
                img: doc2.get('img'),
                like: doc2.get('likes'),
                title: doc2.get('title'),
                uid: doc2.get('uid'),
                doc: doc2,
              );

              dataList.add(list);
              setState(() {
                //
              });
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
      child: dataList.length == 0
          ? Center(
              child: Text('No Articles'),
            )
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: dataList.length,
              itemBuilder: (_, index) {
                return StackArticle(
                  doc: dataList[index].doc,
                  logo: dataList[index].dp,
                  article: dataList[index].article,
                  author: dataList[index].author,
                  uid: dataList[index].uid,
                  title: dataList[index].title,
                  img: dataList[index].img,
                  like: dataList[index].like,
                );
              }),
    );
  }
}
