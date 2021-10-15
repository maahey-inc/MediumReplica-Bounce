import 'package:flutter/material.dart';

class ThemeModel {
  final darkTheme = ThemeData(
    primaryColor: Colors.black,
    backgroundColor: const Color(0xFF212121),
    dividerColor: Colors.grey[700],
    iconTheme: IconThemeData(color: Colors.white),
    appBarTheme: AppBarTheme(color: Colors.black),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(foregroundColor: Colors.white),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
    ),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.grey,
      brightness: Brightness.dark,
    ).copyWith(secondary: Colors.white),
  );

  final lightTheme = ThemeData(
    primaryColor: Colors.white,
    backgroundColor: const Color(0xFFFAFAFA),
    dividerColor: Colors.black54,
    iconTheme: IconThemeData(color: Colors.black),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(foregroundColor: Colors.white),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black54,
    ),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.grey,
      brightness: Brightness.light,
    ).copyWith(secondary: Colors.black),
  );
}
