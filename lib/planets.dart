import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
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
        duration: Duration(milliseconds: 500),
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
        elevation: 0,
        titleSpacing: 0,
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
                    'About',
                    style: GoogleFonts.quicksand(
                        fontSize: 30
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Container(
                    child: Text(
                      'A planet is an astronomical body orbiting a star or stellar remnant that is massive enough to be '
                          'rounded by its own gravity, is not massive enough to cause thermonuclear fusion, and – according to'
                          ' the International Astronomical Union but not all planetary scientists – has cleared its neighbouring region of planetesimals.',
                      style: GoogleFonts.quicksand(
                        fontSize: 17,
                        color: lightmode?Colors.blueGrey[800]:Colors.grey[300],
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
                      'https://en.wikipedia.org/wiki/Planet',
                      style: GoogleFonts.quicksand(
                        decoration: TextDecoration.underline,
                        color: lightmode?Colors.blueGrey[800]:Colors.white
                      ),
                    ),
                    onLongPress: (){
                      Clipboard.setData(ClipboardData(text:'https://en.wikipedia.org/wiki/Planet'));
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Copied to clipboard',style: GoogleFonts.quicksand()),
                            duration: Duration(seconds: 1),
                          )
                      );
                    },
                    onPressed: (){
                      launch('https://en.wikipedia.org/wiki/Planet');
                    },
                  ),
                ),
                SizedBox(height: 30,),
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
                onTap: (){Navigator.pushNamed(context, '/planetinfo',arguments: {'data':planet[index],'dp':false});},
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
