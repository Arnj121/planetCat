import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
class Moons extends StatefulWidget {
  @override
  _MoonsState createState() => _MoonsState();
}

class _MoonsState extends State<Moons> {

  bool lightmode=true,done=false;

  dynamic moon=[],temp;

  Future<void> findMoons()async {
    List<dynamic> list = [];
    List<String> planetList=['uranus','neptune','jupiter','mars','mercure','saturne','terre','venus'];
    List<String> moonList=[];
    temp.forEach((e){
      if(e['isPlanet'] && planetList.contains(e['id']) && e['moons']!=null){
        e['moons'].forEach((moon){
          moonList.add(moon['moon']);
        });
      }
    });
    temp.forEach((e){
      if(moonList.contains(e['name'])){
        list.add(e);
      }
    });
    moon=list;
    this.setState(() {
      done=true;
    });
  }
  @override
  Widget build(BuildContext context) {
    temp=ModalRoute.of(context).settings.arguments;
    findMoons();
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
          'Moons',
          style: GoogleFonts.quicksand(
              color: Colors.pinkAccent
          ),
        ),
        elevation: 0,
        titleSpacing: 0,
        leading: BackButton(
          color: Colors.pinkAccent,
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
                [
                  SizedBox(height: 20,),
                  Center(
                    child: Text(
                      'About',
                      style: GoogleFonts.quicksand(
                          fontSize: 30
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Center(
                    child: Container(
                      child: Text(
                        'A natural satellite, or moon, is, in the most common usage, an astronomical body '
                            'that orbits a planet or minor planet (or sometimes another small Solar System body).',
                        style: GoogleFonts.quicksand(
                            fontSize: 17
                        ),
                        textAlign: TextAlign.center,
                        softWrap: true,
                      ),
                      margin: EdgeInsets.symmetric(vertical: 0,horizontal: 20),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: TextButton(
                      child: Text(
                        'https://en.wikipedia.org/wiki/Natural_satellite',
                        style: GoogleFonts.quicksand(
                            decoration: TextDecoration.underline,
                            color: lightmode?Colors.blueGrey[800]:Colors.white
                        ),
                      ),
                      onLongPress: (){
                        Clipboard.setData(ClipboardData(text:'https://en.wikipedia.org/wiki/Natural_satellite'));
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Copied to clipboard',style: GoogleFonts.quicksand()),
                              duration: Duration(seconds: 1),
                            )
                        );
                      },
                      onPressed: (){
                        launch('https://en.wikipedia.org/wiki/Natural_satellite');
                      },
                    ),
                  ),
                  SizedBox(height: 30,),
                  Center(
                    child: Text(
                      'Moons Found ('+moon.length.toString()+')',
                      style: GoogleFonts.quicksand(
                          fontSize: 30
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ]
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                      (BuildContext context,int index){
                    return MoonBuilder(index);
                  },
                  childCount: this.moon.length
              ),
          ),
          SliverList(delegate: SliverChildListDelegate([SizedBox(height: 20,)]))
        ],
      ),
    );
  }
  Container MoonBuilder(int index){
    return Container(
      child: ListTile(
        onTap: (){Navigator.pushNamed(context, '/mooninfo',arguments: {'data':moon[index],'isUrl':false,'asteroid':false});},
        title:Text(
            moon[index]['englishName'],
            style: GoogleFonts.quicksand(
                color: Colors.pinkAccent,
              fontSize: 20
          ),
        ),
        leading: CircleAvatar(
          child: Icon(
            Icons.circle,
            color: Colors.pinkAccent,
          ),
          backgroundColor: lightmode?Colors.blue:null,
        ),
        subtitle: Text(
          "orbits "+ moon[index]['aroundPlanet']['planet'],
          style: GoogleFonts.quicksand(
              color: Colors.pinkAccent,
          ),
        ),
      ),
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(5),
        color: lightmode?Colors.grey[800]:Colors.grey[300]
      ),
      margin: EdgeInsets.symmetric(vertical: 3,horizontal: 5),
    );
  }
}
