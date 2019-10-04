import 'package:flutter/material.dart';

import 'package:flutter_ec/ui/MainPage.dart';

void main() => runApp(EcApp());

class EcApp extends StatelessWidget{
  static const int primaryValue = 0xFFFE2121;
  static const int primaryLightValue = 0xFFFE2121;
  static const int primaryDarkValue = 0xFFFE2121;
  static const MaterialColor primarySwatch = const MaterialColor(
    primaryValue,
    const <int, Color>{
      50: const Color(primaryLightValue),
      100: const Color(primaryLightValue),
      200: const Color(primaryLightValue),
      300: const Color(primaryLightValue),
      400: const Color(primaryLightValue),
      500: const Color(primaryValue),
      600: const Color(primaryDarkValue),
      700: const Color(primaryDarkValue),
      800: const Color(primaryDarkValue),
      900: const Color(primaryDarkValue),
    },
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: primarySwatch,
      ),
      title: 'ec',
//      theme: ThemeData(primarySwatch: Colors.transparent),
      home: EcMainPage(),
    );
  }
}
