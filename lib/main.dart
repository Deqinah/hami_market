import 'package:flutter/material.dart';
import 'SplashScreen.dart';
import 'HamiApp.dart';


void main() {
  runApp(HamiMiniMarketApp());
}

class HamiMiniMarketApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hami MiniMarket',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Color(0xFF2E7D32),
        scaffoldBackgroundColor: Colors.grey[50],
        fontFamily: 'Roboto',
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}


















