import 'package:flutter/material.dart';
import 'package:mediumreplica/Screens/login.dart';
import 'package:provider/provider.dart';
import 'Shared Prefrences/theme_manager.dart';

void main() {
  runApp(
    ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => new ThemeNotifier(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeNotifier>(context);
    // ThemeData myTheme = ThemeData(
    //   primarySwatch: generateMaterialColor(Palette.primary),
    // );

    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: theme.getTheme(),
      // theme: ThemeData.light(), // Provide light theme
      // darkTheme: ThemeData.dark(), // Provide dark theme
      // theme: myTheme,
      // darkTheme: ThemeData(
      //   primarySwatch: generateMaterialColor(Palette.primary),
      //   brightness: Brightness.dark,
      // ),
      debugShowCheckedModeBanner: false,
      // ignore: unnecessary_null_comparison
      home: theme.getTheme() == null ? Container() : LoginScreen(),
    );
  }
}

class Palette {
  static const Color primary = Colors.black;
}
