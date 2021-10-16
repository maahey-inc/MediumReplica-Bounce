import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:mediumreplica/Screens/settings.dart';
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
  String? currUser = FirebaseAuth.instance.currentUser?.displayName;
  String? dp = FirebaseAuth.instance.currentUser?.photoURL;

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
                  MaterialPageRoute(builder: (context) => Settings()),
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
                              image: NetworkImage('$dp'), fit: BoxFit.fill),
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
                        'Community Manager at Google Developers, Flutter Enthusiast.',
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
                  Text('3 Followers'),
                  VerticalDivider(
                    color: theme.getTheme().brightness == Brightness.dark
                        ? Colors.white54
                        : Colors.black54,
                  ),
                  Text('9 Following'),
                  VerticalDivider(
                    color: theme.getTheme().brightness == Brightness.dark
                        ? Colors.white54
                        : Colors.black54,
                  ),
                  Text('Lists'),
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
                                color: index == 0 ? Colors.white : Colors.grey),
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
                                color: index == 1 ? Colors.white : Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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
