import 'package:mediumreplica/Models/articles.dart';
import 'package:mediumreplica/Screens/lists.dart';
import 'package:mediumreplica/Screens/settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:mediumreplica/Screens/write_article.dart';
import 'package:mediumreplica/Shared%20Prefrences/theme_manager.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final auth = FirebaseAuth.instance;
  String? uidUser = FirebaseAuth.instance.currentUser?.uid;
  String? currUser = FirebaseAuth.instance.currentUser?.displayName;
  String? dp = FirebaseAuth.instance.currentUser?.photoURL;

  String bio = '';
  int followers = 0;
  int following = 0;

  final CollectionReference collection =
      FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    super.initState();

    final DocumentReference collectionDoc =
        collection.doc(uidUser).collection("Profile").doc(uidUser);
    collectionDoc.get().then((DocumentSnapshot document) {
      setState(() {
        uidUser = FirebaseAuth.instance.currentUser?.uid;
        currUser = FirebaseAuth.instance.currentUser?.displayName;
        bio = document['bio'];
        followers = document['followers'];
        following = document['following'];
        print(bio);
      });
      return bio;
    });
    // print(userBio);
  }

  Future<void> getCurrentUserInfo() async {
    User user = auth.currentUser!;
    setState(() {
      currUser = user.toString();
    });
  }

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
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              },
              icon: Icon(Icons.settings)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(
          children: [
            Container(
              height: size.height * 0.17,
              width: size.width * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: size.height * 0.08,
                        height: size.height * 0.08,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage('$dp'), fit: BoxFit.cover),
                        ),
                      ),
                      Container(
                        width: size.width * 0.6,
                        child: Text(
                          '$currUser',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: false,
                          style: TextStyle(
                            fontSize: size.width * 0.045,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: size.width * 0.85,
                      child: Text(
                        bio,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        softWrap: false,
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: size.width * 0.9,
              height: size.height * 0.04,
              child: Divider(),
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('$followers Followers'),
                  VerticalDivider(
                    color: theme.getTheme().brightness == Brightness.dark
                        ? Colors.white54
                        : Colors.black54,
                  ),
                  Text('$following Following'),
                  VerticalDivider(
                    color: theme.getTheme().brightness == Brightness.dark
                        ? Colors.white54
                        : Colors.black54,
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListScreen()));
                      },
                      child: Text('Lists')),
                ],
              ),
            ),
            SizedBox(
              width: size.width * 0.9,
              height: size.height * 0.04,
              child: Divider(),
            ),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        index = 0;
                      });
                    },
                    child: Container(
                      width: size.width * 0.4,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 2.0,
                            color: index == 0
                                ? theme.getTheme().brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black
                                : Colors.transparent,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Center(
                          child: Text(
                            'Articles',
                            style: TextStyle(
                                color: index == 0
                                    ? theme.getTheme().brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black
                                    : Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        index = 1;
                      });
                    },
                    child: Container(
                      width: size.width * 0.4,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 2.0,
                            color: index == 1
                                ? theme.getTheme().brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black
                                : Colors.transparent,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Center(
                          child: Text(
                            'Videos',
                            style: TextStyle(
                                color: index == 1
                                    ? theme.getTheme().brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black
                                    : Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            index == 0
                ? Flexible(
                    child: Center(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: collection
                            .doc(uidUser)
                            .collection("Articles")
                            .orderBy('time', descending: true)
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
                                      padding: const EdgeInsets.all(8.0),
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
                : Flexible(
                    child: Container(
                      child: Center(child: Text('No Videos')),
                    ),
                  ),
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        foregroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.black,
        overlayOpacity: 0.4,
        spacing: 12,
        spaceBetweenChildren: 8,
        children: [
          SpeedDialChild(
            backgroundColor: theme.getTheme().brightness == Brightness.dark
                ? Colors.black87
                : Colors.grey[350],
            child: Icon(Icons.note_add_rounded),
            label: 'Article',
            onTap: () {
              setState(
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WrtieArticleScreen()),
                  );
                },
              );
            },
          ),
          SpeedDialChild(
            backgroundColor: theme.getTheme().brightness == Brightness.dark
                ? Colors.black87
                : Colors.grey[350],
            child: Icon(Icons.videocam_rounded),
            label: 'Video',
          ),
        ],
      ),
    );
  }
}
