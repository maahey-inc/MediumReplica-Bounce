import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediumreplica/Screens/edit_profile.dart';
import 'package:mediumreplica/Screens/login.dart';
import 'package:mediumreplica/Services/auth.dart';
import 'package:mediumreplica/Shared%20Prefrences/theme_manager.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final AuthService auth = AuthService();

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
            Divider(),
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
            Divider(),
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
            Divider(),
            InkWell(
              onTap: () async {
                await auth.signOut();

                // Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false);
              },
              child: Container(
                height: size.height * 0.05,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Sign Out'),
                  ],
                ),
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
