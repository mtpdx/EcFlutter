import 'package:flutter/material.dart';

import 'package:flutter_ec/ui/MainPage.dart';

void main() => runApp(EcApp());

class EcApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ec',
//      theme: ThemeData(primarySwatch: Colors.transparent),
      home: EcMainPage(),
    );
  }
}
