import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
class Exoplanet extends StatefulWidget {
  @override
  _ExoplanetState createState() => _ExoplanetState();
}

class _ExoplanetState extends State<Exoplanet> {

  dynamic kepler,transit;bool done=false,lightmode=false;

  Future initData()async{
    dynamic keplerFieldUrl = Uri.parse('https://exoplanetarchive.ipac.caltech.edu/cgi-bin/nstedAPI/nph-nstedAPI?&table=exoplanets&format=json&where=pl_kepflag=1');
    dynamic transitUrl = Uri.parse('https://exoplanetarchive.ipac.caltech.edu/cgi-bin/nstedAPI/nph-nstedAPI?&table=exoplanets&format=json&where=pl_tranflag=1');

    dynamic res = await http.get(keplerFieldUrl);
    dynamic res1 = await http.get(transitUrl);

    if(res.statusCode==200 && res1.statusCode==200) {
      kepler = jsonDecode(res.body);
      transit = jsonDecode(res1.body);
      this.setState(() {
        done = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{ await initData();});
  }

  @override
  Widget build(BuildContext context) {
    lightmode = MediaQuery.of(context).platformBrightness ==Brightness.light;
    return SafeArea(
      child: Scaffold(
        backgroundColor: lightmode?Colors.white:null,
        appBar: AppBar(
          backgroundColor: lightmode?Colors.white:null,
          title: Text(
            'Exoplanets',
            style: GoogleFonts.quicksand(
              color:Colors.red
            ),
          ),
          leading: BackButton(color: Colors.red,),
        ),
        body: done?CustomScrollView(
          slivers: [
            SliverList(
              delegate:SliverChildListDelegate(
                [
                  SizedBox(height: 20,),
                  Container(
                    child: Text(
                      'Exoplanets',
                      style: GoogleFonts.russoOne(
                        color: Colors.red,
                        fontSize: 50
                      )
                    ),
                    margin: EdgeInsets.symmetric(vertical: 0,horizontal: 15),
                  ),
                  SizedBox(height: 50,),
                  Center(
                    child: Text(
                      'About',
                      style: GoogleFonts.quicksand(
                        color: lightmode?Colors.blueGrey[800]:Colors.white,
                        fontSize: 30
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    child: Center(
                      child: Text(
                        'An exoplanet or extrasolar planet is a planet outside the Solar System. The first possible evidence of an '
                            'exoplanet was noted in 1917, but was not recognized as such.[4] The first confirmation of detection occurred in 1992. '
                            'This was followed by the confirmation of a different planet, originally detected in 1988. There are 4,700+ confirmed exoplanets '
                            'in 3,478 systems, with 770 systems having more than one planet',
                        style: GoogleFonts.quicksand(
                          color: lightmode?Colors.grey[800]:Colors.grey[300],
                          fontSize: 18
                        ),
                        textAlign: TextAlign.center,
                        softWrap: true,
                      ),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 0,horizontal: 20),
                  ),
                  SizedBox(height: 30,),
                  Container(
                    child: Center(
                      child:Text(
                        'Confirmed Planets in the Kepler Field',
                        style: GoogleFonts.quicksand(
                          fontSize: 25,
                          color: lightmode?Colors.blueGrey[800]:Colors.white
                        ),
                        textAlign: TextAlign.center,
                      )
                    ),
                    margin: EdgeInsets.symmetric(vertical: 0,horizontal: 30),
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: Text(
                      kepler.length.toString()+' Found',
                      style: GoogleFonts.quicksand(
                        color: lightmode?Colors.grey[800]:Colors.grey[300],
                        fontSize: 20
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    child: Center(
                        child:Text(
                          'Confirmed Planets that transit their host star',
                          style: GoogleFonts.quicksand(
                              fontSize: 25,
                              color: lightmode?Colors.blueGrey[800]:Colors.white
                          ),
                          textAlign: TextAlign.center,
                        )
                    ),
                    margin: EdgeInsets.symmetric(vertical: 0,horizontal: 30),
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: Text(
                      transit.length.toString()+' Found',
                      style: GoogleFonts.quicksand(
                          color: lightmode?Colors.grey[800]:Colors.grey[300],
                          fontSize: 20
                      ),
                    ),
                  )
                ]
              )
            )
          ],
        ):Center(
          child: SpinKitDualRing(
            lineWidth: 4,
            color: Colors.red,
            size: 50,
            duration: Duration(milliseconds: 500),
          ),
        )
      ),
    );
  }
}
