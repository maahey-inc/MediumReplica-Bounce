import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediumreplica/Screens/comments.dart';
import 'package:zefyrka/zefyrka.dart';

class UserArticle extends StatefulWidget {
  final DocumentSnapshot? doc;
  final String? title, author, logo, article, uid, img;
  final int? like;
  const UserArticle(
      {Key? key,
      this.title,
      this.img,
      this.author,
      this.uid,
      this.doc,
      this.logo,
      this.article,
      this.like})
      : super(key: key);

  @override
  _UserArticleState createState() => _UserArticleState();
}

class _UserArticleState extends State<UserArticle> {
  final auth = FirebaseAuth.instance;
  User? uidUser = FirebaseAuth.instance.currentUser;

  late Timer timer;

  late Timer tapTimer;

  var likeCounter = 0;

  Icon like = Icon(Icons.thumb_up_alt_outlined);

  int selectedIndex = 0;

  bool visible = true;

  bool likeButtonVisible = false;

  ZefyrController controller = ZefyrController();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .doc('${uidUser!.uid}')
        .collection('following')
        .get()
        .then((snapshot) {
      for (var doc in snapshot.docs) {
        if (widget.uid == doc.get('uid')) {
          doc.get('uid');
          setState(() {
            visible = false;
          });
        }
      }
    });

    loadDocument().then((doc) {
      setState(() {
        controller = ZefyrController(doc);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 20, 12, 8),
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(widget.logo!),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          width: size.width * 0.6,
                          child: Text(
                            widget.author!,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                      icon: Icon(CupertinoIcons.clear_circled_solid),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    Container(
                      width: size.width * 0.9,
                      child: Text(
                        widget.title!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Image(
                        image: NetworkImage(widget.doc!.get('img')),
                        fit: BoxFit.cover,
                      )),
                ),
              ),
              Container(
                child: ZefyrEditor(
                  controller: controller,
                  readOnly: true,
                  scrollable: true,
                  scrollPhysics: BouncingScrollPhysics(),
                  showCursor: false,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        showSelectedLabels: false,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: _onTap,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'Like',
            icon: GestureDetector(
              //ontap
              onTap: () async {
                print('tap down');

                setState(() {
                  like = Icon(
                    Icons.thumb_up_alt,
                  );
                  likeCounter++;
                });
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc('${uidUser!.uid}')
                    .collection("Articles")
                    .doc('${widget.doc!.id}')
                    .update({
                  'likes': widget.like! + likeCounter,
                });
              },

              //onlongpress increment
              onLongPressDown: (details) async {
                print('down');

                timer = Timer.periodic(Duration(milliseconds: 100), (t) {
                  setState(() {
                    likeButtonVisible = true;
                    like = Icon(
                      Icons.thumb_up_alt,
                    );
                    likeCounter++;
                  });

                  print('value $likeCounter');
                });
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc('${uidUser!.uid}')
                    .collection("Articles")
                    .doc('${widget.doc!.id}')
                    .update({
                  'likes': widget.like! + likeCounter,
                });
              },

              //onlong press button cancel
              onLongPressUp: () async {
                print('up');
                setState(() {
                  likeButtonVisible = false;
                });
                timer.cancel();
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc('${uidUser!.uid}')
                    .collection("Articles")
                    .doc('${widget.doc!.id}')
                    .update({
                  'likes': widget.like! + likeCounter,
                });
              },

              onLongPressCancel: () async {
                print('cancel');
                setState(() {
                  likeButtonVisible = false;
                });
                timer.cancel();
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc('${uidUser!.uid}')
                    .collection("Articles")
                    .doc('${widget.doc!.id}')
                    .update({
                  'likes': widget.like! + likeCounter,
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  like,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text('${widget.like! + likeCounter}'),
                  ),
                ],
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Comment',
            icon: Icon(Icons.chat_bubble_outline_sharp),
          ),
          BottomNavigationBarItem(
            label: 'Share',
            icon: Icon(Icons.share),
          ),
          BottomNavigationBarItem(
            label: 'Menu',
            icon: PopupMenuButton(
              icon: Icon(Icons.more_vert),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: 'edit',
                    child: Text('Edit Article'),
                  ),
                  PopupMenuItem(
                    value: 'del',
                    child: Text('Delete Article'),
                  ),
                  PopupMenuItem(
                    value: 'save',
                    child: Text('Save to List'),
                  ),
                  likeCounter != 0
                      ? PopupMenuItem(
                          value: 'undo',
                          child: Text('Undo Likes'),
                        )
                      : PopupMenuItem(
                          value: ' ',
                          child: Text(''),
                        ),
                ];
              },
              onSelected: (String value) => actionPopUpItemSelected(value),
            ),
          ),
        ],
      ),
      floatingActionButton: Stack(
        children: [
          likeButtonVisible
              ? Positioned(
                  left: 30,
                  bottom: 10,
                  child: FloatingActionButton(
                    heroTag: null,
                    child: Text(
                      '+$likeCounter',
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    tooltip: 'Follow',
                    onPressed: () {},
                  ),
                )
              : Container(),
          widget.uid != '${uidUser!.uid}'
              ? visible
                  ? Positioned(
                      right: 10,
                      bottom: 15,
                      child: FloatingActionButton(
                        heroTag: null,
                        child: Icon(
                          Icons.person_add_alt_1,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.white
                                  : Colors.black,
                        ),
                        tooltip: 'Follow',
                        onPressed: () async {
                          setState(() {
                            visible = false;

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text('Author "${widget.author}" Followed'),
                            ));
                          });
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc('${uidUser!.uid}')
                              .collection('following')
                              .add({
                            'author': widget.author,
                            'uid': widget.uid,
                          });
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(widget.uid)
                              .collection('followers')
                              .add({
                            'author': '${uidUser!.displayName}',
                            'uid': '${uidUser!.uid}',
                          });
                        },
                      ),
                    )
                  : Container()
              : Container(),
        ],
      ),
    );
  }

  void _onTap(int index) {
    setState(() {
      selectedIndex = index;
    });
    if (selectedIndex == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CommentsSscreen(
                    doc: '${widget.doc!.id}',
                    uid: '${uidUser!.uid}',
                    author: widget.author!,
                    dp: widget.logo!,
                  )));
    }
  }

  Future<void> actionPopUpItemSelected(String choice) async {
    if (choice == 'undo') {
      print('Undo');
      setState(() {
        likeCounter = 0;
        like = Icon(Icons.thumb_up_alt_outlined);
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc('${uidUser!.uid}')
          .collection("Articles")
          .doc('${widget.doc!.id}')
          .update({
        'likes': widget.like! - likeCounter,
      });
    } else if (choice == ' ') {
      print(' ');
    } else if (choice == 'edit') {
      print('edit');
    } else if (choice == 'del') {
      print('del');
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uidUser!.uid)
          .collection("Articles")
          .doc('${widget.doc!.id}')
          .delete();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uidUser!.uid)
          .collection("Articles")
          .doc('${widget.doc!.id}')
          .collection('Comments')
          .get()
          .then((snapshot) {
        for (DocumentSnapshot doc in snapshot.docs) {
          doc.reference.delete();
        }
      });

      Navigator.pop(context);
    } else if (choice == 'save') {
      await saveDocument(context);
    }
  }

  Future<void> saveDocument(BuildContext context) async {
    final contents = jsonEncode(controller.document);
    await FirebaseFirestore.instance
        .collection('users')
        .doc('${uidUser!.uid}')
        .collection("Lists")
        .doc(widget.doc!.id)
        .set({
      'doc': widget.doc!.id,
    });
  }

  Future loadDocument() async {
    return NotusDocument.fromJson(jsonDecode(widget.article!));
  }
}
