import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediumreplica/Screens/edit_profile.dart';
import 'package:mediumreplica/Shared%20Prefrences/theme_manager.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeNotifier>(context);

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.getTheme().backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Container(
              height: size.height * 0.05,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Dark Mode'),
                  CupertinoSwitch(
                    ///dark light mode
                    value: theme.getTheme().brightness == Brightness.dark
                        ? true
                        : false,
                    onChanged: (bool value) {
                      setState(() {
                        if (theme.getTheme().brightness == Brightness.light) {
                          theme.setDarkMode();
                        } else if (theme.getTheme().brightness ==
                            Brightness.dark) {
                          theme.setLightMode();
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
            Divider(
              color: theme.getTheme().brightness == Brightness.dark
                  ? Colors.grey[700]
                  : Colors.black54,
            ),
            GestureDetector(
              // onTap: () {
              //   Navigator.push(context,
              //       MaterialPageRoute(builder: (context) => EditProfile()));
              // },
              child: Container(
                height: size.height * 0.05,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Start your Pulication'),
                  ],
                ),
              ),
            ),
            Divider(
              color: theme.getTheme().brightness == Brightness.dark
                  ? Colors.grey[700]
                  : Colors.black54,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditProfile()));
              },
              child: Container(
                height: size.height * 0.05,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Edit Profile'),
                  ],
                ),
              ),
            ),
            Divider(
              color: theme.getTheme().brightness == Brightness.dark
                  ? Colors.grey[700]
                  : Colors.black54,
            ),
            Container(
              height: size.height * 0.05,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Sign Out'),
                ],
              ),
            ),
            Divider(
              color: theme.getTheme().brightness == Brightness.dark
                  ? Colors.grey[700]
                  : Colors.black54,
            ),
          ],
        ),
      ),
    );
  }
}
