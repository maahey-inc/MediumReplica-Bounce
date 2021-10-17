import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mediumreplica/Models/articles.dart';
import 'package:mediumreplica/Shared%20Prefrences/theme_manager.dart';
import 'package:provider/provider.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final auth = FirebaseAuth.instance;
  String? uidUser = FirebaseAuth.instance.currentUser?.uid;
  String? currUser = FirebaseAuth.instance.currentUser?.displayName;
  String? dp = FirebaseAuth.instance.currentUser?.photoURL;

  final CollectionReference collection =
      FirebaseFirestore.instance.collection('users');
  int index = 0;

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
        title: Text('Your Lists'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        index = 0;
                      });
                    },
                    child: Container(
                      width: size.width * 0.4,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'Saved',
                            style: TextStyle(
                                color: index == 0 ? Colors.white : Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ),
                  VerticalDivider(),
                  InkWell(
                    onTap: () {
                      setState(() {
                        index = 1;
                      });
                    },
                    child: Container(
                      width: size.width * 0.4,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'Recently viewed',
                            style: TextStyle(
                                color: index == 1 ? Colors.white : Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            index == 0
                ? Expanded(
                    child: Center(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: collection
                            .doc(uidUser)
                            .collection("Lists")
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          return !snapshot.hasData
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : snapshot.data?.docs.length == 0
                                  ? Text('No Articles')
                                  : Padding(
                                      padding: const EdgeInsets.only(top: 12),
                                      child: ListView.separated(
                                        physics: BouncingScrollPhysics(),
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return SizedBox(
                                            height: 2,
                                          );
                                        },
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder: (context, index) {
                                          DocumentSnapshot doc =
                                              snapshot.data!.docs[index];
                                          return StackArticle(
                                            doc: doc,
                                            logo: snapshot.data!.docs[index]
                                                ['dp'],
                                            article: snapshot.data!.docs[index]
                                                ['article'],
                                            author: snapshot.data!.docs[index]
                                                ['author'],
                                            uid: snapshot.data!.docs[index]
                                                ['uid'],
                                            title: snapshot.data!.docs[index]
                                                ['title'],
                                            img: snapshot.data!.docs[index]
                                                ['img'],
                                            like: snapshot.data!.docs[index]
                                                ['likes'],
                                          );
                                        },
                                      ),
                                    );
                        },
                      ),
                    ),
                  )
                : Expanded(
                    child: Center(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: collection
                            .doc(uidUser)
                            .collection("Recent")
                            .orderBy('time', descending: true)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          return !snapshot.hasData
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : snapshot.data?.docs.length == 0
                                  ? Text('Nothing viewed yet.')
                                  : Padding(
                                      padding: const EdgeInsets.only(top: 12),
                                      child: ListView.separated(
                                        physics: BouncingScrollPhysics(),
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return SizedBox(
                                            height: 2,
                                          );
                                        },
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder: (context, index) {
                                          DocumentSnapshot doc =
                                              snapshot.data!.docs[index];
                                          return StackArticle(
                                            doc: doc,
                                            logo: snapshot.data!.docs[index]
                                                ['dp'],
                                            article: snapshot.data!.docs[index]
                                                ['article'],
                                            author: snapshot.data!.docs[index]
                                                ['author'],
                                            uid: snapshot.data!.docs[index]
                                                ['uid'],
                                            title: snapshot.data!.docs[index]
                                                ['title'],
                                            img: snapshot.data!.docs[index]
                                                ['img'],
                                            like: snapshot.data!.docs[index]
                                                ['likes'],
                                          );
                                        },
                                      ),
                                    );
                        },
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
