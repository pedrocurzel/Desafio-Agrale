import 'package:agrale/screens/home/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
    color: Colors.white,
    theme: ThemeData(
      backgroundColor: Colors.white,
      fontFamily: 'Verdana'
    ),
  ));
}