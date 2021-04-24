import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class Asteroid extends StatefulWidget {
  @override
  _AsteroidState createState() => _AsteroidState();
}

class _AsteroidState extends State<Asteroid> {
  bool lightmode=true,done=false;
  dynamic asteroids=[],temp;

  Future<void> findAsteroids()async {
    List<dynamic> list = [];
    List<String> planetList=['uranus','neptune','jupiter','mars','mercure','saturne','terre','venus'];
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
                  SizedBox(height: 20),
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
