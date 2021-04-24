import 'package:flutter/material.dart';
import 'package:planet/home.dart';
import 'package:planet/loading.dart';
import 'package:planet/bodies.dart';
import 'package:planet/planetInfo.dart';

void main(){runApp(MyApp());}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: ThemeData(
        brightness: Brightness.light
      ),
      darkTheme:ThemeData(
        brightness: Brightness.dark
      ),
      initialRoute: '/loading',
      routes: {
       '/loading':(context)=>Loading(),
        '/home':(context)=>Home(),
        '/bodies':(context)=>Bodies(),
        '/planetinfo':(context)=>PlanetInfo()
      },
    );
  }
}
