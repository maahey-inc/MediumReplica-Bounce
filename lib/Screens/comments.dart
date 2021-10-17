import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mediumreplica/Shared%20Prefrences/theme_manager.dart';
import 'package:provider/provider.dart';

class CommentsSscreen extends StatefulWidget {
  final String doc, uid, author, dp;
  const CommentsSscreen({
    Key? key,
    required this.doc,
    required this.uid,
    required this.author,
    required this.dp,
  }) : super(key: key);

  @override
  _CommentsSscreenState createState() => _CommentsSscreenState();
}

class _CommentsSscreenState extends State<CommentsSscreen> {
  TextEditingController controller = TextEditingController();

  final CollectionReference collection =
      FirebaseFirestore.instance.collection('users');
  User? uidUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var theme = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      backgroundColor: theme.getTheme().brightness == Brightness.dark
          ? Theme.of(context).backgroundColor
          : Colors.grey[100],
      appBar: AppBar(
        title: Text('Comments'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            //msg area
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: collection
                        .doc(uidUser!.uid)
                        .collection("Articles")
                        .doc('${widget.doc}')
                        .collection('Comments')
                        .orderBy('time', descending: true)
                        .snapshots(),
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
                                      return Container(
                                        child: ListTile(
                                            trailing: PopupMenuButton(
                                                icon: Icon(Icons.more_vert),
                                                itemBuilder: (context) {
                                                  return [
                                                    PopupMenuItem(
                                                      value: 'del',
                                                      child: Text('Delete'),
                                                    ),
                                                  ];
                                                },
                                                onSelected: (value) async {
                                                  await collection
                                                      .doc(uidUser!.uid)
                                                      .collection("Articles")
                                                      .doc('${widget.doc}')
                                                      .collection('Comments')
                                                      .doc(doc.id)
                                                      .delete();
                                                }),
                                            isThreeLine: true,
                                            title: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 20,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                              snapshot.data!
                                                                      .docs[
                                                                  index]['dp'],
                                                            ),
                                                            fit: BoxFit.cover),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8),
                                                      child: Text(
                                                        snapshot.data!
                                                                .docs[index]
                                                            ['author'],
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  snapshot.data!.docs[index]
                                                      ['time'],
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.grey),
                                                )
                                              ],
                                            ),
                                            subtitle: Text(
                                              '\n${snapshot.data!.docs[index]["comment"]}',
                                              style: TextStyle(fontSize: 12),
                                            )),
                                      );
                                    },
                                  ),
                                );
                    },
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      width: 1.0, color: theme.getTheme().dividerColor),
                ),
              ),
              height: size.height * 0.1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Container(
                      width: size.width * 0.75,
                      child: TextField(
                        controller: controller,
                        maxLines: 2,
                        decoration:
                            InputDecoration(hintText: 'Add your comment'),
                      ),
                    ),
                    TextButton(
                        onPressed: () async {
                          if (controller.value.text.length > 0) {
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc('${widget.uid}')
                                .collection("Articles")
                                .doc('${widget.doc}')
                                .collection('Comments')
                                .add({
                              'time': DateFormat("MM-d-yy hh:mm a")
                                  .format(DateTime.now()),
                              'author': '${uidUser!.displayName}',
                              'dp': '${uidUser!.photoURL}',
                              'comment': controller.text,
                            });
                            controller.clear();
                          }
                        },
                        child: Text('Post'))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
