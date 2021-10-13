import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArticleScreen extends StatefulWidget {
  final String? img, title, author, logo, article;
  final int? like;
  const ArticleScreen(
      {Key? key,
      this.img,
      this.title,
      this.author,
      this.logo,
      this.article,
      this.like})
      : super(key: key);

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  late Timer timer;

  late Timer tapTimer;

  var likeCounter = 0;

  Icon like = Icon(Icons.thumb_up_alt_outlined);

  int selectedIndex = 0;

  bool visible = true;

  bool likeButtonVisible = false;

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
                        child: Text(
                          widget.author!,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
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
                    Text(
                      widget.title!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  width: size.width * 0.9,
                  height: size.height * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.grey,
                    image: DecorationImage(
                        image: NetworkImage(widget.img!), fit: BoxFit.cover),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.article!,
                        style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
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
              onTap: () {
                print('tap down');

                setState(() {
                  like = Icon(
                    Icons.thumb_up_alt,
                  );
                  likeCounter++;
                });
              },

              //onlongpress increment
              onLongPressDown: (details) {
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
              },

              //onlong press button cancel
              onLongPressUp: () {
                print('up');
                setState(() {
                  likeButtonVisible = false;
                });
                timer.cancel();
              },

              onLongPressCancel: () {
                print('cancel');
                setState(() {
                  likeButtonVisible = false;
                });
                timer.cancel();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  like,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text('$likeCounter'),
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
            label: 'Groups',
            icon: Icon(Icons.collections_bookmark),
          ),
          BottomNavigationBarItem(
            label: 'Menu',
            icon: PopupMenuButton(
              icon: Icon(Icons.more_vert),
              itemBuilder: (context) {
                return [
                  likeCounter != 0
                      ? PopupMenuItem(
                          value: 'undo',
                          child: Text('Undo Likes'),
                        )
                      : PopupMenuItem(
                          value: 'articles',
                          child: Text('Articles Only'),
                        )
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
          visible
              ? Positioned(
                  right: 10,
                  bottom: 15,
                  child: FloatingActionButton(
                    heroTag: null,
                    child: Icon(
                      Icons.person_add_alt_1,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.white
                          : Colors.black,
                    ),
                    tooltip: 'Follow',
                    onPressed: () {
                      setState(() {
                        visible = false;
                        // showToast();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Author "${widget.author}" Followed'),
                        ));
                      });
                    },
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  void _onTap(int index) {
    setState(() {
      selectedIndex = index;
    });
    if (selectedIndex == 4) {}
  }

  void actionPopUpItemSelected(String choice) {
    if (choice == 'undo') {
      print('Undo');
      setState(() {
        likeCounter = 0;
        like = Icon(Icons.thumb_up_alt_outlined);
      });
    } else if (choice == 'articles') {
      print('Articles');
    }
  }
}
