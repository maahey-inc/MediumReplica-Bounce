import 'package:flutter/material.dart';
import 'package:mediumreplica/Screens/lists.dart';
import 'package:mediumreplica/Screens/search.dart';
import 'package:mediumreplica/Screens/profile.dart';
import 'package:mediumreplica/Screens/home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  Icon home = Icon(
    Icons.home,
  );
  Icon search = Icon(
    Icons.search,
  );
  Icon lists = Icon(
    Icons.bookmarks_outlined,
  );
  Icon profile = Icon(
    Icons.account_circle_outlined,
  );
  Icon group = Icon(
    Icons.collections_bookmark_outlined,
  );

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      Home(),
      SearchScreen(),
      ListScreen(),
      ProfileScreen(),
      Icon(
        Icons.group,
        size: 100,
        color: Colors.purple,
      ),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).backgroundColor,

      body: pages.elementAt(selectedIndex),

      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        showSelectedLabels: false,
        unselectedItemColor: Colors.grey,
        // selectedItemColor: Theme.of(context),

        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: _onTap,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'Home',
            icon: home,
          ),
          BottomNavigationBarItem(
            label: 'Search',
            icon: search,
          ),
          BottomNavigationBarItem(
            label: 'Lists',
            icon: lists,
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: profile,
          ),
          BottomNavigationBarItem(
            label: 'Groups',
            icon: group,
          ),
        ],
      ),

      //
    );
  }

  void actionPopUpItemSelected(String choice) {
    if (choice == 'videos') {
      print('Videos');
    } else if (choice == 'articles') {
      print('Articles');
    }
  }

  void _onTap(int index) {
    setState(() {
      selectedIndex = index;
    });
    selectedIndex == 0
        ? home = Icon(Icons.home)
        : home = Icon(Icons.home_outlined);
    selectedIndex == 1
        ? search = Icon(Icons.search)
        : search = Icon(Icons.search);
    selectedIndex == 2
        ? lists = Icon(Icons.bookmarks)
        : lists = Icon(Icons.bookmarks_outlined);
    selectedIndex == 3
        ? profile = Icon(Icons.account_circle)
        : profile = Icon(Icons.account_circle_outlined);
    selectedIndex == 4
        ? group = Icon(Icons.collections_bookmark)
        : group = Icon(Icons.collections_bookmark_outlined);
  }
}
