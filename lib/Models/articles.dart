import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mediumreplica/Screens/user_article.dart';

class Article {
  String? logo, author, title, img, article;
  int? like;

  Article(
      {this.logo, this.author, this.title, this.img, this.like, this.article});
}

List<Article> getArticles() {
  return [
    Article(
      img:
          "https://images.unsplash.com/photo-1535295972055-1c762f4483e5?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fGdpcmwlMjBpbiUyMGhvb2RpZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
      author: 'Arthur Conan Doyle',
      title: 'Flutter vs React',
      logo:
          'https://www.thedroidsonroids.com/wp-content/uploads/2019/06/flutter_blog-react-vs-flutter.png',
      like: 54,
    ),
    Article(
      img:
          "https://images.unsplash.com/photo-1535295972055-1c762f4483e5?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fGdpcmwlMjBpbiUyMGhvb2RpZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
      author: 'Arthur Conan Doyle',
      title: 'Flutter vs React',
      logo:
          'https://www.thedroidsonroids.com/wp-content/uploads/2019/06/flutter_blog-react-vs-flutter.png',
      like: 54,
    ),
    Article(
      img:
          "https://images.unsplash.com/photo-1535295972055-1c762f4483e5?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fGdpcmwlMjBpbiUyMGhvb2RpZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
      author: 'Arthur Conan Doyle',
      title: 'Flutter vs React',
      logo:
          'https://www.thedroidsonroids.com/wp-content/uploads/2019/06/flutter_blog-react-vs-flutter.png',
      like: 54,
    ),
    Article(
      img:
          "https://images.unsplash.com/photo-1535295972055-1c762f4483e5?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fGdpcmwlMjBpbiUyMGhvb2RpZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
      author: 'Arthur Conan Doyle',
      title: 'Flutter vs React',
      logo:
          'https://www.thedroidsonroids.com/wp-content/uploads/2019/06/flutter_blog-react-vs-flutter.png',
      like: 54,
    ),
  ];
}

class StackArticle extends StatelessWidget {
  final String logo, author, uid, title, img;
  final dynamic article;
  final DocumentSnapshot doc;
  final int like;

  const StackArticle(
      {Key? key,
      required this.logo,
      required this.article,
      required this.doc,
      required this.author,
      required this.uid,
      required this.title,
      required this.img,
      required this.like})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UserArticle(
                      doc: doc,
                      logo: logo,
                      uid: uid,
                      author: author,
                      title: title,
                      like: like,
                      article: article,
                    )));

        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection("Recent")
            .doc(doc.id)
            .set({
          'article': article,
          'time': DateFormat("MM-d-yyyy hh:mm a").format(DateTime.now()),
          'title': title,
          'likes': like,
          'uid': uid,
          'author': author,
          'dp': logo,
          'img': doc.get('img'),
          'doc': doc.id,
        });
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: size.width * 0.6,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 0),
                      child: Row(
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(logo), fit: BoxFit.cover),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              author,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Row(
                        children: [
                          Container(
                            width: size.width * 0.55,
                            child: Text(
                              title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: false,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 8),
                      child: Row(
                        children: [
                          Icon(
                            Icons.thumb_up,
                            size: 18,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Text(
                              '$like',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: size.width * 0.2,
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(3),
                    image: DecorationImage(
                      image: NetworkImage(img),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
