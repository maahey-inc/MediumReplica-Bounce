import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mediumreplica/Models/articles.dart';
import 'package:mediumreplica/Shared%20Prefrences/theme_manager.dart';
import 'package:mediumreplica/Widgets/recent_list.dart';
import 'package:mediumreplica/Widgets/save_lists.dart';
import 'package:mediumreplica/constants.dart';
import 'package:provider/provider.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeNotifier>(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
          bottom: TabBar(
            indicatorColor: theme.getTheme().brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
            tabs: [
              Tab(
                icon: Icon(Icons.bookmarks),
                text: 'Saved',
              ),
              Tab(
                icon: Icon(Icons.preview_rounded),
                text: 'Recently viewed',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [SavedList(), RecentList()],
        ),
      ),
    );
  }
}
