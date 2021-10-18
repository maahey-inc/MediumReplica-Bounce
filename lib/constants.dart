import 'package:cloud_firestore/cloud_firestore.dart';

String method = 'articles';

List<String> tags = [];

class Data {
  String dp, author, article, img, title, uid;
  DocumentSnapshot doc;
  int like;

  Data(
      {required this.dp,
      required this.author,
      required this.article,
      required this.img,
      required this.title,
      required this.uid,
      required this.doc,
      required this.like});
}

class Recent {
  String dp, author, article, img, title, uid;
  DocumentSnapshot doc;
  int like;

  Recent(
      {required this.dp,
      required this.author,
      required this.article,
      required this.img,
      required this.title,
      required this.uid,
      required this.doc,
      required this.like});
}

class Recommend {
  String dp, author, article, img, title, uid;
  DocumentSnapshot doc;
  int like;

  Recommend(
      {required this.dp,
      required this.author,
      required this.article,
      required this.img,
      required this.title,
      required this.uid,
      required this.doc,
      required this.like});
}
