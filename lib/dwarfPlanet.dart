import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
class DwarfPlanet extends StatefulWidget {
  @override
  _DwarfPlanetState createState() => _DwarfPlanetState();
}

class _DwarfPlanetState extends State<DwarfPlanet> {

  bool lightmode=true,done=false;
  dynamic dplanets=[],temp;
  Future initData()async{
    List<dynamic> list = [];
    List<String> planetList=['uranus','neptune','jupiter','mars','mercure','saturne','terre','venus'];
    temp.forEach((e){
      if(e['isPlanet'] && !planetList.contains(e['id'])){
        list.add(e);
      }
    });
    dplanets=list;
    this.setState(() {
      done=true;
    });
  }

  @override void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{await initData();});
  }

  @override
  Widget build(BuildContext context) {
    lightmode = MediaQuery.of(context).platformBrightness ==Brightness.light;
    temp=ModalRoute.of(context).settings.arguments;
    return done?MainPage():Loading();
  }
  Scaffold Loading(){
    return Scaffold(
      backgroundColor: lightmode?Colors.white:null,
      body: Center(
        child: SpinKitDualRing(
          lineWidth: 3,
          color: Colors.deepPurpleAccent,
          duration: Duration(milliseconds: 500),
        ),
      ),
    );
  }
  Scaffold MainPage(){
    return Scaffold(
      backgroundColor: lightmode?Colors.white:null,
      appBar: AppBar(
        backgroundColor: lightmode?Colors.white:null,
        leading: BackButton(color: Colors.brown[400]),
        title: Text(
          'Dwarf Planets',
          style: GoogleFonts.quicksand(
            color: Colors.brown[400]
          ),
        ),
        titleSpacing: 0,
        elevation: 0,
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
                      'A dwarf planet is a planetary-mass object that is neither a true planet nor a natural satellite; '
                          'it is in direct orbit of a star, and is massive enough for its gravity to compress it into a hydrostatically '
                          'equilibrious shape (usually a spheroid), but has not cleared the neighborhood of other material around its orbit.',
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
                      'https://en.wikipedia.org/wiki/Planet#Dwarf_planets',
                      style: GoogleFonts.quicksand(
                          decoration: TextDecoration.underline,
                          color: lightmode?Colors.blueGrey[800]:Colors.white
                      ),
                    ),
                    onLongPress: (){
                      Clipboard.setData(ClipboardData(text:'https://en.wikipedia.org/wiki/Planet#Dwarf_planets'));
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Copied to clipboard',style: GoogleFonts.quicksand()),
                            duration: Duration(seconds: 1),
                          )
                      );
                    },
                    onPressed: (){
                      launch('https://en.wikipedia.org/wiki/Planet#Dwarf_planets');
                    },
                  ),
                ),
                SizedBox(height: 30,),
                Center(
                  child: Text(
                    'Dwarf Planets Found ('+dplanets.length.toString()+')',
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
                  childCount: this.dplanets.length
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
                    image: AssetImage('./assets/dplanet/${dplanets[index]['id']}.jpg'),
                    fit: BoxFit.cover
                ),
                borderRadius: BorderRadius.circular(5)
            ),
          ),
          Center(
            child: ListTile(
              onTap: (){Navigator.pushNamed(context, '/planetinfo',arguments: {'data':dplanets[index],'dp':true});},
              title: Center(
                child: Text(
                  dplanets[index]['englishName'],
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
