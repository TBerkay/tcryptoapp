import 'package:flutter/material.dart';
import 'package:tcryptoapp/screens/coin_list_screen.dart';
import 'package:tcryptoapp/screens/splashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark),
      home: SplashScreen(),
      routes: {
        '/coins' : (BuildContext context) => CoinListScreen(),
      },
    );
  }
}
