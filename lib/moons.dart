import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
class Planets extends StatefulWidget {
  @override
  _PlanetsState createState() => _PlanetsState();
}

class _PlanetsState extends State<Planets> {

  bool lightmode=true,done=false;

  dynamic planet=[],temp;

  Future<void> findPlanets()async {
    List<dynamic> list = [];
    List<String> planetList=['uranus','neptune','jupiter','mars','mercure','saturne','terre','venus'];
    temp.forEach((e){
      if(e['isPlanet'] && planetList.contains(e['id'])){
        list.add(e);
      }
    });
    planet=list;
    this.setState(() {
      done=true;
    });
  }
  @override
  Widget build(BuildContext context) {
    temp=ModalRoute.of(context).settings.arguments;
    findPlanets();
    lightmode = MediaQuery.of(context).platformBrightness ==Brightness.light;
    return SafeArea(
        child:done?MainPage():Loading()
    );
  }
  Scaffold Loading(){
    return Scaffold(
      backgroundColor: lightmode?Colors.white:null,
      body: SpinKitDualRing(
        color: Colors.deepPurpleAccent,
        size: 50,
        lineWidth: 4,
        duration: Duration(milliseconds: 400),
      ),
    );
  }
  Scaffold MainPage(){
    return Scaffold(
      backgroundColor: lightmode?Colors.white:null,
      appBar: AppBar(
        backgroundColor: lightmode?Colors.white:null,
        title: Text(
          'Planets',
          style: GoogleFonts.quicksand(
              color: Colors.orangeAccent
          ),
        ),
        leading: BackButton(
          color: Colors.orangeAccent,
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
                [
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Planets Found ('+planet.length.toString()+')',
                      style: GoogleFonts.quicksand(
                          fontSize: 30
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ]
            ),
          ),
          SliverGrid(
              delegate: SliverChildBuilderDelegate(
                      (BuildContext context,int index){
                    return PlanetBuilder(index);
                  },
                  childCount: this.planet.length
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 5
              )
          ),
          SliverList(delegate: SliverChildListDelegate([SizedBox(height: 20,)]))
        ],
      ),
    );
  }
  Container PlanetBuilder(int index){
    return Container(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('./assets/planet/${planet[index]['id']}.jpg'),
                    fit: BoxFit.cover
                ),
                borderRadius: BorderRadius.circular(5)
            ),
          ),
          Center(
            child: ListTile(
              onTap: (){Navigator.pushNamed(context, '/planetinfo',arguments: planet[index]);},
              title: Center(
                child: Text(
                  planet[index]['englishName'],
                  style: GoogleFonts.quicksand(
                      fontSize: 30,
                      color: Colors.white
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      margin: EdgeInsets.symmetric(vertical: 0,horizontal: 5),
    );
  }
}
