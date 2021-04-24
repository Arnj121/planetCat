import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
class MoonInfo extends StatefulWidget {
  @override
  _MoonInfoState createState() => _MoonInfoState();
}

class _MoonInfoState extends State<MoonInfo> {
  bool lightmode=true,done=false;
  dynamic moonInfo=[];dynamic u;
  String type='moon';
  Future initData()async{
    if(u['isUrl']) {
      u = u['url'];
      dynamic url = Uri.parse(u);
      dynamic response = await http.get(
          url, headers: {"accept": 'application/json'});
      if (response.statusCode == 200)
        moonInfo = jsonDecode(response.body);
    }
    else{
      moonInfo=u['data'];
      type = u['asteroid']? 'asteroid':'moon';
    }
    this.setState(() {
      moonInfo = moonInfo;
      done = true;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{ await initData();});
  }


  @override
  Widget build(BuildContext context) {
    lightmode = MediaQuery.of(context).platformBrightness == Brightness.light;
    u = ModalRoute.of(context).settings.arguments;
    return done? SafeArea(
      child: Scaffold(
        backgroundColor: lightmode?Colors.white:null,
        appBar: AppBar(
          backgroundColor: lightmode?Colors.white:null,
          title: Text(
            moonInfo['englishName'],
            style: GoogleFonts.quicksand(
              color: Colors.redAccent
            ),
          ),
          elevation: 0,
          titleSpacing: 0,
          leading: BackButton(color: Colors.redAccent,),
        ),
        body: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SizedBox(height: 30,),
                  Center(
                      child: Container(
                        child: Text(
                          moonInfo['name'],
                          style: GoogleFonts.quicksand(
                              color: lightmode?Colors.blueGrey[900]:Colors.white,
                              fontSize:30
                          ),
                        ),
                      )
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: Container(
                      child: Text(
                        'It\'s a $type!',
                        style: GoogleFonts.quicksand(
                          fontSize: 20,
                          color: lightmode?Colors.blueGrey[800]:Colors.grey[300],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: Text(
                      'English name : '+moonInfo['englishName'],
                      style: GoogleFonts.quicksand(
                        fontSize: 20,
                        color: lightmode?Colors.blueGrey[800]:Colors.grey[300]
                      ),
                    ),
                    // margin: EdgeInsets.symmetric(vertical: 20,horizontal: 15),
                  ),
                  Visibility(
                    visible: moonInfo['discoveredBy'].length==0?false:true,
                      child:Column(
                          children:[
                            SizedBox(height: 10,),
                            Center(
                              child: Text(
                                'Discovered by : '+moonInfo['discoveredBy'],
                                style: GoogleFonts.quicksand(
                                  fontSize: 20,
                                  color: lightmode?Colors.blueGrey[800]:Colors.grey[300]
                                ),
                              )
                            )
                          ]
                      )
                  ),
                  Visibility(
                      visible: moonInfo['discoveryDate'].length==0?false:true,
                      child:Column(
                          children:[
                            SizedBox(height: 10,),
                            Center(
                                child: Text(
                                  'Discovery Date : '+moonInfo['discoveryDate'],
                                  style: GoogleFonts.quicksand(
                                      fontSize: 20,
                                      color: lightmode?Colors.blueGrey[800]:Colors.grey[300]
                                  ),
                                )
                            )
                          ]
                      )
                  ),
                  SizedBox(height: 30,),
                  Center(
                    child: Text(
                      'About',
                      style: GoogleFonts.quicksand(
                        fontSize: 30,
                        color: lightmode?Colors.blueGrey[900]:Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: Text(
                      moonInfo['mass']==null? 'Mass : 0':
                      'Mass : '+moonInfo['mass']['massValue'].toString()+'^'+moonInfo['mass']['massExponent'].toString(),
                      style: GoogleFonts.quicksand(
                          fontSize: 20,
                          color: lightmode?Colors.blueGrey[800]:Colors.grey[300]
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: Text(
                      moonInfo['vol']==null?'Volume : 0':
                      'Volume : '+moonInfo['vol']['volValue'].toString()+'^'+moonInfo['vol']['volExponent'].toString(),
                      style: GoogleFonts.quicksand(
                          fontSize: 20,
                          color: lightmode?Colors.blueGrey[800]:Colors.grey[300]
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: Text(
                      'Density : '+moonInfo['density'].toString()+' g/cm3',
                      style: GoogleFonts.quicksand(
                          fontSize: 20,
                          color: lightmode?Colors.blueGrey[800]:Colors.grey[300]
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: Text(
                      'Gravity : '+moonInfo['gravity'].toString()+ ' m/s2',
                      style: GoogleFonts.quicksand(
                          fontSize: 20,
                          color: lightmode?Colors.blueGrey[800]:Colors.grey[300]
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: Text(
                      'Escape Velocity : '+(moonInfo['escape']/1000).toString()+' km/s',
                      style: GoogleFonts.quicksand(
                          fontSize: 20,
                          color: lightmode?Colors.blueGrey[800]:Colors.grey[300]
                      ),
                    ),
                  ),

                  SizedBox(height: 10,),
                  Center(
                    child: Text(
                      'Equator Radius : '+moonInfo['equaRadius'].toString()+' km',
                      style: GoogleFonts.quicksand(
                          fontSize: 20,
                          color: lightmode?Colors.blueGrey[800]:Colors.grey[300]
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: Text(
                      'Polar Radius : '+moonInfo['polarRadius'].toString()+' km',
                      style: GoogleFonts.quicksand(
                          fontSize: 20,
                          color: lightmode?Colors.blueGrey[800]:Colors.grey[300]
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: Text(
                      'Mean Radius : '+moonInfo['meanRadius'].toString()+' km',
                      style: GoogleFonts.quicksand(
                          fontSize: 20,
                          color: lightmode?Colors.blueGrey[800]:Colors.grey[300]
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: Text(
                      'Axial Tilt : '+moonInfo['axialTilt'].toString()+' deg',
                      style: GoogleFonts.quicksand(
                          fontSize: 20,
                          color: lightmode?Colors.blueGrey[800]:Colors.grey[300]
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: Text(
                      moonInfo['aroundPlanet']==null?'Around Planet : ':
                      'Around Planet : '+moonInfo['aroundPlanet']['planet'].toString(),
                      style: GoogleFonts.quicksand(
                          fontSize: 20,
                          color: lightmode?Colors.blueGrey[800]:Colors.grey[300]
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Center(
                    child: Text(
                      'Orbital Details',
                      style: GoogleFonts.quicksand(
                          fontSize: 30,
                          color: lightmode?Colors.blueGrey[900]:Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: Text(
                      'Orbital Period : '+moonInfo['sideralOrbit'].toString()+ ' ED',
                      style: GoogleFonts.quicksand(
                          fontSize: 20,
                          color: lightmode?Colors.blueGrey[800]:Colors.grey[300]
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: Text(
                      'Rotational Period : '+moonInfo['sideralRotation'].toString()+ ' ED',
                      style: GoogleFonts.quicksand(
                          fontSize: 20,
                          color: lightmode?Colors.blueGrey[800]:Colors.grey[300]
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: Text(
                      'SemiMajor Axis : '+moonInfo['semimajorAxis'].toString()+' km',
                      style: GoogleFonts.quicksand(
                          fontSize: 20,
                          color: lightmode?Colors.blueGrey[800]:Colors.grey[300]
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: Text(
                      'Perihelion : '+moonInfo['perihelion'].toString()+' km',
                      style: GoogleFonts.quicksand(
                          fontSize: 20,
                          color: lightmode?Colors.blueGrey[800]:Colors.grey[300]
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: Text(
                      'Aphelion : '+moonInfo['aphelion'].toString()+' km',
                      style: GoogleFonts.quicksand(
                          fontSize: 20,
                          color: lightmode?Colors.blueGrey[800]:Colors.grey[300]
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: Text(
                      'Eccentricity : '+moonInfo['eccentricity'].toString(),
                      style: GoogleFonts.quicksand(
                          fontSize: 20,
                          color: lightmode?Colors.blueGrey[800]:Colors.grey[300]
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: Text(
                      'Inclination : '+moonInfo['inclination'].toString()+' deg',
                      style: GoogleFonts.quicksand(
                          fontSize: 20,
                          color: lightmode?Colors.blueGrey[800]:Colors.grey[300]
                      ),
                    ),
                  ),
                  SizedBox(height: 50,),
                ]
              ),
            ),
          ],
        ),
      ),
    ):Loading();
  }
  Scaffold Loading(){
    return Scaffold(
      backgroundColor: lightmode?Colors.white:null,
      body: Container(
        child: SpinKitDualRing(
          color: Colors.deepPurpleAccent,
          lineWidth: 3,
          duration: Duration(milliseconds: 500),
        ),
      ),
    );
  }
}
