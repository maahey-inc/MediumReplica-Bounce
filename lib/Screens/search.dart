import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mediumreplica/Models/articles.dart';
import 'package:mediumreplica/Shared%20Prefrences/theme_manager.dart';
import 'package:mediumreplica/constants.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final auth = FirebaseAuth.instance;
  User? uidUser = FirebaseAuth.instance.currentUser;

  final CollectionReference collection =
      FirebaseFirestore.instance.collection('tags');
  DocumentSnapshot? doc;
  String? searchKey;

  bool searchState = false;

  List<Recommend> recList = [];

  @override
  void initState() {
    super.initState();
    recList.clear();
    collection.get().then((snapshot) {
      for (DocumentSnapshot doc1 in snapshot.docs) {
        collection.doc(doc1.id).collection('Articles').get().then((snapshot) {
          for (DocumentSnapshot doc2 in snapshot.docs) {
            Recommend list = Recommend(
              dp: doc2.get('dp'),
              author: doc2.get('author'),
              article: doc2.get('article'),
              img: doc2.get('img'),
              like: doc2.get('likes'),
              title: doc2.get('title'),
              uid: doc2.get('uid'),
              doc: doc2,
            );

            recList.add(list);
            setState(() {});
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var theme = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      backgroundColor: theme.getTheme().brightness == Brightness.dark
          ? Theme.of(context).backgroundColor
          : Colors.grey[100],
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: theme.getTheme().brightness == Brightness.dark
            ? Theme.of(context).backgroundColor
            : Colors.grey[100],
        elevation: 0,
        title: Text('Search'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 16, 12, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: theme.getTheme().brightness == Brightness.dark
                    ? Colors.black87
                    : Colors.grey[350],
                borderRadius: BorderRadius.circular(6),
              ),
              child: TextField(
                style: TextStyle(
                  color: theme.getTheme().brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
                textCapitalization: TextCapitalization.sentences,
                cursorColor: theme.getTheme().brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    color: theme.getTheme().brightness == Brightness.dark
                        ? Colors.white54
                        : Colors.black54,
                  ),
                  hintText: "Search by Tag",
                  hintStyle: TextStyle(
                    color: theme.getTheme().brightness == Brightness.dark
                        ? Colors.white54
                        : Colors.black54,
                  ),
                ),
                onChanged: (text) async {
                  setState(() {
                    searchKey = text;
                  });
                },
              ),
            ),
            SizedBox(
              height: size.width * 0.05,
            ),
            Container(
                child: Text(
              'Recommended',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                color: theme.getTheme().brightness == Brightness.dark
                    ? Colors.white54
                    : Colors.black54,
              ),
            )),
            SizedBox(
              width: size.width * 0.9,
              child: Divider(
                color: theme.getTheme().brightness == Brightness.dark
                    ? Colors.white54
                    : Colors.black54,
              ),
            ),
            Expanded(
              child: recList.length == 0
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: recList.length,
                      itemBuilder: (_, index) {
                        return StackArticle(
                          doc: recList[index].doc,
                          logo: recList[index].dp,
                          article: recList[index].article,
                          author: recList[index].author,
                          uid: recList[index].uid,
                          title: recList[index].title,
                          img: recList[index].img,
                          like: recList[index].like,
                        );
                      }),
            ),
            // Flexible(
            //   child: StreamBuilder<QuerySnapshot>(
            //     stream:
            //         //  (searchKey != "" && searchKey != null)
            //         //     ? collection.startAt([searchKey]).endAt(
            //         //         [searchKey! + '\uf8ff']).snapshots()
            //         //     :
            //         collection.doc().collection('Articles').snapshots(),
            //     builder: (BuildContext context,
            //         AsyncSnapshot<QuerySnapshot> snapshot) {
            //       return !snapshot.hasData
            //           ? Center(
            //               child: CircularProgressIndicator(),
            //             )
            //           : snapshot.data!.docs.length == 0
            //               ? Center(child: Text('No Articles'))
            //               : Padding(
            //                   padding: const EdgeInsets.all(8.0),
            //                   child: ListView.separated(
            //                     physics: BouncingScrollPhysics(),
            //                     separatorBuilder:
            //                         (BuildContext context, int index) {
            //                       return SizedBox(
            //                         height: 2,
            //                       );
            //                     },
            //                     itemCount: snapshot.data!.docs.length,
            //                     itemBuilder: (context, index) {
            //                       DocumentSnapshot doc =
            //                           snapshot.data!.docs[index];
            //                       return StackArticle(
            //                         doc: doc,
            //                         logo: snapshot.data!.docs[index]['dp'],
            //                         article: snapshot.data!.docs[index]
            //                             ['article'],
            //                         author: snapshot.data!.docs[index]
            //                             ['author'],
            //                         uid: snapshot.data!.docs[index]['uid'],
            //                         title: snapshot.data!.docs[index]['title'],
            //                         img: snapshot.data!.docs[index]['img'],
            //                         like: snapshot.data!.docs[index]['likes'],
            //                       );
            //                     },
            //                   ),
            //                 );
            //     },
            //   ),
            // ),
            // Expanded(
            //   child: ListView.builder(
            //     physics: BouncingScrollPhysics(),
            //     itemCount: 8,
            //     itemBuilder: (context, index) {
            //       return StackArticle(
            //         doc: doc!,
            //         uid: '345',
            //         article: 'Hi',
            //         logo:
            //             "https://images.unsplash.com/photo-1535295972055-1c762f4483e5?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fGdpcmwlMjBpbiUyMGhvb2RpZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
            //         author: 'Arthur Conan Doyle',
            //         title: 'Flutter vs React',
            //         img:
            //             'https://www.thedroidsonroids.com/wp-content/uploads/2019/06/flutter_blog-react-vs-flutter.png',
            //         like: 54,
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
