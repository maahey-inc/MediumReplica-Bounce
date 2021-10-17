import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mediumreplica/Shared%20Prefrences/theme_manager.dart';
import 'package:mediumreplica/constants.dart';
import 'package:provider/provider.dart';

class TagsScreen extends StatefulWidget {
  const TagsScreen({Key? key}) : super(key: key);

  @override
  _TagsScreenState createState() => _TagsScreenState();
}

class _TagsScreenState extends State<TagsScreen> {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('tags');

  final CollectionReference usersCollec =
      FirebaseFirestore.instance.collection('user');

  User? uidUser = FirebaseAuth.instance.currentUser;

  Color? btnColor = Colors.grey[350];

  List<dynamic> tagSelected = [];

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
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Your Tags'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
              onPressed: () async {
                for (var i = 0; i < tagSelected.length; i++) {
                  for (var j = 0; j < tags.length; j++) {
                    if (tags.contains(tagSelected[i])) {
                      print('${tagSelected[i]} available');
                      break;
                    } else {
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc('${uidUser!.uid}')
                          .collection("tags")
                          .doc()
                          .set({'tag': tagSelected[i]});
                      break;
                    }
                  }
                }
                Navigator.pop(context);
              },
              child: Text(
                'Save',
                style: TextStyle(color: Colors.blue),
              )),
        ],
      ),
      body: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text('Your Tags', style: TextStyle(color: Colors.grey)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  height: size.height * 0.05,
                  child: tags.length == 0
                      ? Center(
                          child: Text(
                          'No tags',
                          style: TextStyle(color: Colors.grey),
                        ))
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: tags.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.black12
                                      : Colors.grey[600],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  child: Center(
                                    child: Text(
                                      tags[index],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text('New Tags', style: TextStyle(color: Colors.grey)),
              ),
              Container(
                  height: size.height * 0.05,
                  child: tagSelected.length == 0
                      ? Center(
                          child: Text(
                            'No new tags selected',
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: tagSelected.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.black12
                                      : Colors.grey[600],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  child: Center(
                                    child: Text(
                                      tagSelected[index],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          })),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: collection.snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      return !snapshot.hasData
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : snapshot.data?.docs.length == 0
                              ? Text('No comments yet')
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      DocumentSnapshot doc =
                                          snapshot.data!.docs[index];

                                      return Container(
                                        child: TextButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      btnColor)),
                                          onPressed: () {
                                            // for (var k = 0;
                                            //     k < tags.length;
                                            //     k++) {
                                            //   for (var i = 0;
                                            //       i < tagSelected.length;
                                            //       i++) {
                                            //     if(tagSelected.contains(snapshot
                                            //       .data!.docs[index]['tag'])){}
                                            //   }
                                            // }
                                            for (var i = 0;
                                                i < tagSelected.length;
                                                i++) {
                                              if (tagSelected.contains(snapshot
                                                  .data!.docs[index]['tag'])) {
                                                tagSelected.remove(snapshot
                                                    .data!.docs[index]['tag']);
                                              }
                                            }
                                            setState(() {
                                              tagSelected.add(snapshot
                                                  .data!.docs[index]['tag']);
                                            });
                                          },
                                          child: Text(
                                            snapshot.data!.docs[index]['tag'],
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                    },
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
