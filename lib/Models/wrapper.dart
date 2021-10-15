import 'package:flutter/material.dart';
import 'package:mediumreplica/Models/user.dart';
import 'package:mediumreplica/Screens/login.dart';
import 'package:mediumreplica/Widgets/bottom_navbar.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //
    final user = Provider.of<Users?>(context);
    print(user);

    //return home or login widget
    if (user == null) {
      return LoginScreen();
    } else {
      return HomeScreen();
    }
  }
}
