import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mediumreplica/Models/articles.dart';
import 'package:mediumreplica/Shared%20Prefrences/theme_manager.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DocumentSnapshot? doc;

  bool searchState = false;

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
                    // searchKey = text.substring(0, 1).toUpperCase() +
                    //     text.substring(1).toLowerCase();
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
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: 8,
                itemBuilder: (context, index) {
                  return StackArticle(
                    doc: doc!,
                    uid: '345',
                    article: 'Hi',
                    logo:
                        "https://images.unsplash.com/photo-1535295972055-1c762f4483e5?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fGdpcmwlMjBpbiUyMGhvb2RpZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
                    author: 'Arthur Conan Doyle',
                    title: 'Flutter vs React',
                    img:
                        'https://www.thedroidsonroids.com/wp-content/uploads/2019/06/flutter_blog-react-vs-flutter.png',
                    like: 54,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
