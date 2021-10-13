import 'package:flutter/material.dart';
import 'package:mediumreplica/Models/authenticate.dart';
import 'package:mediumreplica/Models/user.dart';
import 'package:provider/provider.dart';
import '../screens/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //
    final user = Provider.of<User>(context);
    print(user);

    //return home or authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
