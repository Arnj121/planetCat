import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlanetInfo extends StatefulWidget {
  @override
  _PlanetInfoState createState() => _PlanetInfoState();
}

class _PlanetInfoState extends State<PlanetInfo> {
  bool lightmode=true;
  dynamic planetInfo=[],temp;String dir='';
  @override
  Widget build(BuildContext context) {
    lightmode = MediaQuery.of(context).platformBrightness == Brightness.light;
    temp=ModalRoute.of(context).settings.arguments;
    planetInfo=temp['data'];
    dir = temp['dp']?'dplanet':'planet';
    return SafeArea(
      child: Scaffold(
        backgroundColor: lightmode?Colors.white:null,
        appBar: AppBar(
          backgroundColor: lightmode?Colors.white:null,
          title: Text(
            planetInfo['englishName'],
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
                        decoration: BoxDecoration(
                            image:DecorationImage(
                                image: AssetImage('./assets/$dir/${planetInfo['id']}.jpg'),
                                fit: BoxFit.cover
                            ),
                            borderRadius: BorderRadius.circular(100)
                        ),
                        height: 200,
                        width: 200,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Center(
                        child: Container(
                          child: Text(
                            planetInfo['name'],
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
                          temp['dp']?'It\'s a dwarf planet!': 'It\'s a planet',
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
                        'English name : '+planetInfo['englishName'],
                        style: GoogleFonts.quicksand(
                            fontSize: 20,
                            color: lightmode?Colors.blueGrey[800]:Colors.grey[300]
                        ),
                      ),
                      // margin: EdgeInsets.symmetric(vertical: 20,horizontal: 15),
                    ),
                    SizedBox(height: 10,),
                    Center(
                      child: Text(
                        planetInfo['moons']==null?'Moons : 0': 'Moons : ${planetInfo['moons'].length.toString()}',
                        style: GoogleFonts.quicksand(
                            fontSize: 20,
                            color: lightmode?Colors.blueGrey[800]:Colors.grey[300]
                        ),
                      ),
                    ),
                    Visibility(
                        visible: planetInfo['discoveredBy'].length==0?false:true,
                        child:Column(
                            children:[
                              SizedBox(height: 10,),
                              Container(
                                child: Center(
                                    child: Text(
                                      'Discovered by : '+planetInfo['discoveredBy'],
                                      style: GoogleFonts.quicksand(
                                          fontSize: 20,
                                          color: lightmode?Colors.blueGrey[800]:Colors.grey[300]
                                      ),
                                    )
                                ),
                                margin: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                              )
                            ]
                        )
                    ),
                    Visibility(
                        visible: planetInfo['discoveryDate'].length==0?false:true,
                        child:Column(
                            children:[
                              SizedBox(height: 10,),
                              Center(
                                  child: Text(
                                    'Discovery Date : '+planetInfo['discoveryDate'],
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
                        'Mass : '+planetInfo['mass']['massValue'].toString()+'^'+planetInfo['mass']['massExponent'].toString(),
                        style: GoogleFonts.quicksand(
                            fontSize: 20,
                            color: lightmode?Colors.blueGrey[800]:Colors.grey[300]
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Center(
                      child: Text(
                        'Volume : '+planetInfo['vol']['volValue'].toString()+'^'+planetInfo['vol']['volExponent'].toString(),
                        style: GoogleFonts.quicksand(
                            fontSize: 20,
                            color: lightmode?Colors.blueGrey[800]:Colors.grey[300]
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Center(
                      child: Text(
                        'Density : '+planetInfo['density'].toString()+' g/cm3',
                        style: GoogleFonts.quicksand(
                            fontSize: 20,
                            color: lightmode?Colors.blueGrey[800]:Colors.grey[300]
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Center(
                      child: Text(
                        'Gravity : '+planetInfo['gravity'].toString()+ ' m/s2',
                        style: GoogleFonts.quicksand(
                            fontSize: 20,
                            color: lightmode?Colors.blueGrey[800]:Colors.grey[300]
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Center(
                      child: Text(
                        'Escape Velocity : '+(planetInfo['escape']/1000).toString()+' km/s',
                        style: GoogleFonts.quicksand(
                            fontSize: 20,
                            color: lightmode?Colors.blueGrey[800]:Colors.grey[300]
                        ),
                      ),
                    ),

                    SizedBox(height: 10,),
                    Center(
                      child: Text(
                        'Equator Radius : '+planetInfo['equaRadius'].toString()+' km',
                        style: GoogleFonts.quicksand(
                            fontSize: 20,
                            color: lightmode?Colors.blueGrey[800]:Colors.grey[300]
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Center(
                      child: Text(
                        'Polar Radius : '+planetInfo['polarRadius'].toString()+' km',
                        style: GoogleFonts.quicksand(
                            fontSize: 20,
                            color: lightmode?Colors.blueGrey[800]:Colors.grey[300]
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Center(
                      child: Text(
                        'Mean Radius : '+planetInfo['meanRadius'].toString()+' km',
                        style: GoogleFonts.quicksand(
                            fontSize: 20,
                            color: lightmode?Colors.blueGrey[800]:Colors.grey[300]
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Center(
                      child: Text(
                        'Axial Tilt : '+planetInfo['axialTilt'].toString()+' deg',
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
                        'Orbital Period : '+planetInfo['sideralOrbit'].toString()+ ' ED',
                        style: GoogleFonts.quicksand(
                            fontSize: 20,
                            color: lightmode?Colors.blueGrey[800]:Colors.grey[300]
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Center(
                      child: Text(
                        'Rotational Period : '+planetInfo['sideralRotation'].toString()+ ' ED',
                        style: GoogleFonts.quicksand(
                            fontSize: 20,
                            color: lightmode?Colors.blueGrey[800]:Colors.grey[300]
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Center(
                      child: Text(
                        planetInfo['semimajoraxis']==null? 'SemiMajor Axis : '+planetInfo['semimajorAxis'].toString()+' km':'SemiMajor Axis : '+planetInfo['semimajoraxis'].toString()+' km',
                        style: GoogleFonts.quicksand(
                            fontSize: 20,
                            color: lightmode?Colors.blueGrey[800]:Colors.grey[300]
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Center(
                      child: Text(
                        'Perihelion : '+planetInfo['perihelion'].toString()+' km',
                        style: GoogleFonts.quicksand(
                            fontSize: 20,
                            color: lightmode?Colors.blueGrey[800]:Colors.grey[300]
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Center(
                      child: Text(
                        'Aphelion : '+planetInfo['aphelion'].toString()+' km',
                        style: GoogleFonts.quicksand(
                            fontSize: 20,
                            color: lightmode?Colors.blueGrey[800]:Colors.grey[300]
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Center(
                      child: Text(
                        'Eccentricity : '+planetInfo['eccentricity'].toString(),
                        style: GoogleFonts.quicksand(
                            fontSize: 20,
                            color: lightmode?Colors.blueGrey[800]:Colors.grey[300]
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Center(
                      child: Text(
                        'Inclination : '+planetInfo['inclination'].toString()+' deg',
                        style: GoogleFonts.quicksand(
                            fontSize: 20,
                            color: lightmode?Colors.blueGrey[800]:Colors.grey[300]
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    Visibility(
                      visible: planetInfo['moons']==null?false:true,
                      child: Center(
                        child: Text(
                            planetInfo['moons']==null?'':'Moons ('+planetInfo['moons'].length.toString()+')',
                          style: GoogleFonts.quicksand(
                              fontSize: 30,
                              color: lightmode?Colors.blueGrey[900]:Colors.white
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5,),
                    Visibility(
                      visible: planetInfo['moons']==null?false:true,
                      child: Center(
                        child: Text(
                          '(click to get more info)',
                          style: GoogleFonts.quicksand(
                              fontSize: 15,
                              color: lightmode?Colors.blueGrey[800]:Colors.white
                          ),
                        ),
                      ),
                    ),
                  ]
              ),
            ),
            SliverVisibility(
                visible: planetInfo['moons']==null?false:true,
                sliver:SliverList(
                  delegate: SliverChildBuilderDelegate(
                          (BuildContext context,int index){
                        return Center(
                          child: Container(
                            child: TextButton(
                              child: Text(
                                planetInfo['moons'][index]['moon'],
                                style: GoogleFonts.quicksand(
                                    color: lightmode?Colors.blueGrey[800]:Colors.grey[300],
                                    fontSize:20,
                                    decoration: TextDecoration.underline
                                ),
                              ),
                              onPressed: (){Navigator.pushNamed(context,'/mooninfo',arguments: {'url':planetInfo['moons'][index]['rel'],'isUrl':true});},
                            ),
                            margin: EdgeInsets.symmetric(vertical: 0,horizontal: 0),
                          ),
                        );
                      },
                      childCount: planetInfo['moons']==null?0:planetInfo['moons'].length
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
