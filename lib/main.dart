import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Models/user.dart';
import 'Models/wrapper.dart';
import 'Services/auth.dart';
import 'Shared Prefrences/theme_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //await GetStorage.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeNotifier>(
            create: (_) => new ThemeNotifier()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeNotifier>(context);

    return StreamProvider<Users?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        themeMode: ThemeMode.system,
        // theme: theme.getTheme(),
        darkTheme: theme.getTheme(),
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}

class Palette {
  static const Color primary = Colors.black;
}
