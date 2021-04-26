import 'package:flutter/material.dart';
import 'package:planet/home.dart';
import 'package:planet/loading.dart';
import 'package:planet/moonInfo.dart';
import 'package:planet/settings.dart';
import 'package:planet/planets.dart';
import 'package:planet/planetInfo.dart';
import 'package:planet/moons.dart';
import 'package:planet/dwarfPlanet.dart';
import 'package:planet/asteroid.dart';
import 'package:planet/search.dart';
import 'package:planet/whereIsISS.dart';
import 'package:planet/exoplanets.dart';
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
        '/planetinfo':(context)=>PlanetInfo(),
        '/settings':(context)=>Settings(),
        '/planets':(context)=>Planets(),
        '/mooninfo':(context)=>MoonInfo(),
        '/moons':(context)=>Moons(),
        '/dwarf':(context)=>DwarfPlanet(),
        '/asteroid':(context)=>Asteroid(),
        '/search':(context)=>Search(),
        '/whereisiss':(context)=>WhereIsISS(),
        '/exoplanet':(context)=>Exoplanet()
      },
    );
  }
}
