import 'package:agrale/Screens/Menu/menu_screen.dart';
import 'package:agrale/screens/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('pt_BR', null);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    //home: HomePage(),
    color: Colors.white,
    theme: ThemeData(
      backgroundColor: Colors.white,
      fontFamily: 'Verdana'
    ),
    initialRoute: '/',
    routes: {
      '/': (context) => const HomePage(),
      '/menu': (context) => MenuScreen(),
    },
  ));
}