import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart'as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/services.dart';
class WhereIsISS extends StatefulWidget {
  @override
  _WhereIsISSState createState() => _WhereIsISSState();
}

class _WhereIsISSState extends State<WhereIsISS> {

  bool lightmode=true,done=false;
  dynamic data=[];
  Future getIss()async{
    dynamic url =Uri.parse('https://api.wheretheiss.at/v1/satellites/25544');
    dynamic response = await http.get(url);
    if(response.statusCode==200){
      data = jsonDecode(response.body);
      print(data);
      this.setState(() {
        done=true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{ await getIss();});
  }

  @override
  Widget build(BuildContext context) {
    lightmode = MediaQuery.of(context).platformBrightness ==Brightness.light;
    return SafeArea(
      child: Scaffold(
        backgroundColor: lightmode?Colors.white:null,
        appBar:AppBar(
          backgroundColor: lightmode?Colors.white:null,
          title: Text(
            'Where is ISS?',
            style: GoogleFonts.quicksand(
              color: Colors.blue
            ),
          ),
          leading: BackButton(color: Colors.blue,),
          actions: [
            IconButton(
              icon: Icon(
                Icons.refresh,
                color:Colors.blue,
              ),
              onPressed: ()async{this.setState(() {
                done=false;
              });await getIss();},
            )
          ],
        ),
        body: done?CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                  [
                    SizedBox(height: 50,),
                    Center(
                      child: Text(
                        'ISS',
                        style: GoogleFonts.quicksand(
                          fontSize: 35
                        ),
                      ),
                    ),
                    SizedBox(height: 50,),
                    Center(
                      child: Icon(
                        CupertinoIcons.location,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Center(
                      child: Text(
                        'Longitude : '+data['longitude'].toStringAsFixed(4).toString()+' deg',
                        style: GoogleFonts.quicksand(
                          fontSize: 20
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Center(
                      child: Text(
                        'Longitude : '+data['latitude'].toStringAsFixed(4).toString()+' deg',
                        style: GoogleFonts.quicksand(
                            fontSize: 20
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Center(
                      child: Icon(
                        CupertinoIcons.alt,
                        color: Colors.orange,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Center(
                      child: Text(
                        'Altitude : '+data['altitude'].toStringAsFixed(4).toString()+' km',
                        style: GoogleFonts.quicksand(
                            fontSize: 20
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Center(
                      child: Icon(
                        CupertinoIcons.speedometer,
                        color: Colors.redAccent,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Center(
                      child: Text(
                        'Velocity : '+data['velocity'].toStringAsFixed(4).toString() + ' km/s',
                        style: GoogleFonts.quicksand(
                            fontSize: 20
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Center(
                      child: Icon(
                        CupertinoIcons.moon_fill,
                        color: data['visibility']=='daylight'?Colors.grey[500]:Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Center(
                      child: Text(
                        'Visibility : '+data['visibility'].toString(),
                        style: GoogleFonts.quicksand(
                            fontSize: 20
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Center(
                      child: Text(
                        'Solar latitude : '+data['solar_lat'].toStringAsFixed(4).toString()+ ' deg',
                        style: GoogleFonts.quicksand(
                            fontSize: 20
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Center(
                      child: Text(
                        'Solar longitude : '+data['solar_lon'].toStringAsFixed(4).toString()+ ' deg',
                        style: GoogleFonts.quicksand(
                            fontSize: 20
                        ),
                      ),
                    ),
                    SizedBox(height: 50,),
                    Center(
                      child: ElevatedButton(
                        child: Text(
                          'Show in google maps',
                          style: GoogleFonts.quicksand(
                            color: Colors.grey[300],
                            fontSize: 17
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                        ),
                        onPressed: (){
                          String url = 'https://www.google.com/maps?z=1&t=m&q=loc:${data['latitude']}+${data['longitude']}';
                          launch(url);
                        },
                        onLongPress: (){
                          Clipboard.setData(ClipboardData(text:'https://www.google.com/maps?z=1&t=m&q=loc:${data['latitude']}+${data['longitude']}'));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Copied to clipboard',style: GoogleFonts.quicksand()),
                              duration: Duration(seconds: 1),
                            )
                          );
                        },
                      ),
                    )
                  ]
              ),
            )
          ],
        ):Center(
          child: SpinKitDualRing(
            lineWidth: 4,
            color: Colors.blue,
            duration: Duration(milliseconds: 500),
            size: 50,
          ),
        )
      ),
    );
  }
}
