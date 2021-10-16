import 'package:flutter/material.dart';
import 'package:mediumreplica/Shared%20Prefrences/theme_manager.dart';
import 'package:provider/provider.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
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
                        child: Text(
                          'Saved',
                          style: TextStyle(
                              color: index == 0 ? Colors.white : Colors.grey),
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
                        child: Text(
                          'Recently viewed',
                          style: TextStyle(
                              color: index == 1 ? Colors.white : Colors.grey),
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
    );
  }
}
