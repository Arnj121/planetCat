import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
class Asteroid extends StatefulWidget {
  @override
  _AsteroidState createState() => _AsteroidState();
}

class _AsteroidState extends State<Asteroid> {
  bool lightmode=true,done=false;
  dynamic asteroids=[],temp;

  Future<void> findAsteroids()async {
    List<dynamic> list = [];
    List<String> planetList=['uranus','neptune','jupiter','mars','mercure','saturne','terre','venus','soleil'];
    List<String> moonList=[];
    temp.forEach((e){
      if(e['isPlanet'] && !planetList.contains(e['id'])){
        planetList.add(e['id']);
      }
    });
    temp.forEach((e){
      if(planetList.contains(e['id']) && e['moons']!=null)
        e['moons'].forEach((moon){
          moonList.add(moon['moon']);
        });
    });
    temp.forEach((e){
      if(!moonList.contains(e['name']) && !planetList.contains(e['id'])){
        list.add(e);
      }
    });
    print(list.length);
    asteroids=list;
    this.setState(() {
      done=true;
    });
  }

  @override
  Widget build(BuildContext context) {
    temp=ModalRoute.of(context).settings.arguments;
    findAsteroids();
    lightmode = MediaQuery.of(context).platformBrightness ==Brightness.light;
    return done?MainPage():Loading();
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
          'Asteroids',
          style: GoogleFonts.quicksand(
              color: Colors.purple[400]
          ),
        ),
        elevation: 0,
        titleSpacing: 0,
        leading: BackButton(
          color: Colors.purple[400],
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
                        'An asteroid is a minor planet of the inner Solar System. Historically, '
                            'these terms have been applied to any astronomical object orbiting the Sun that did not resolve'
                            ' into a disc in a telescope and was not observed to have characteristics of an active comet such as a tail.',
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
                        'https://en.wikipedia.org/wiki/Asteroid',
                        style: GoogleFonts.quicksand(
                            decoration: TextDecoration.underline,
                            color: lightmode?Colors.blueGrey[800]:Colors.white
                        ),
                      ),
                      onLongPress: (){
                        Clipboard.setData(ClipboardData(text:'https://en.wikipedia.org/wiki/Asteroid'));
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Copied to clipboard',style: GoogleFonts.quicksand()),
                              duration: Duration(seconds: 1),
                            )
                        );
                      },
                      onPressed: (){
                        launch('https://en.wikipedia.org/wiki/Asteroid');
                      },
                    ),
                  ),
                  SizedBox(height: 30,),
                  Center(
                    child: Text(
                      'Asteroids Found ('+asteroids.length.toString()+')',
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
                  return AsteroidBuilder(index);
                },
                childCount: this.asteroids.length
            ),
          ),
          SliverList(delegate: SliverChildListDelegate([SizedBox(height: 20,)]))
        ],
      ),
    );
  }
  Container AsteroidBuilder(int index){
    return Container(
      child: ListTile(
        onTap: (){Navigator.pushNamed(context, '/mooninfo',arguments: {'data':asteroids[index],'isUrl':false,'asteroid':true});},
        title:Text(
          asteroids[index]['englishName'],
          style: GoogleFonts.quicksand(
              color: Colors.white
          ),
        ),
        leading: CircleAvatar(
          child: Icon(
            Icons.circle,
            color: Colors.white,
          ),
          backgroundColor: lightmode?Colors.blue:null,
        ),
        subtitle: Text(
          "Alternate name "+ asteroids[index]['alternativeName'],
          style: GoogleFonts.quicksand(
            color: Colors.grey[300],
          ),
        ),
      ),
      decoration: BoxDecoration(
          color: Colors.purple[200]
      ),
      margin: EdgeInsets.symmetric(vertical: 3,horizontal: 5),
    );
  }
}
