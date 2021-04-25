import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  dynamic bodies=[];bool lightmode=true,planet=false,moons=false,asteroids=false,all=true;
  TextEditingController searchCont = TextEditingController();
  List<String> planetList=[],moonList=[],asteroidList=[];
  List<String> mainPlanets=['uranus','neptune','jupiter','mars','mercury','saturn','earth','venus'];
  List<dynamic> searchResults=[];
  RegExp match;
  void listNames(){
    dynamic temp=[];planetList=[];moonList=[];asteroidList=[];
    bodies.forEach((e){
      if(e['isPlanet']){
        planetList.add(e['englishName']);
      }
    });
    bodies.forEach((e){
      if(e['isPlanet'] && e['moons']!=null)
        e['moons'].forEach((moon){
          temp.add(moon['moon']);
        });
    });
    bodies.forEach((e){
      if(temp.contains(e['name'])){
        moonList.add(e['englishName']);
      }
    });
    bodies.forEach((e){
      if(!moonList.contains(e['englishName']) && !planetList.contains(e['englishName'])){
        asteroidList.add(e['englishName']);
      }
    });
  }

  dynamic searchName(text){
    searchResults.clear();
    match = RegExp('$text',caseSensitive: false);
    if(planet || all)
      planetList.forEach((e){
        if(match.hasMatch(e)){
          searchResults.add({'name':e,'type':'planet'});
        }
      });
    if(moons || all)
      moonList.forEach((e){
        if(match.hasMatch(e)){
          searchResults.add({'name':e,'type':'moon'});
        }
      });
    if(asteroids || all)
      asteroidList.forEach((e){
        if(match.hasMatch(e)){
          searchResults.add({'name':e,'type':'asteroid'});
        }
      });
    this.setState(() {
      searchResults=searchResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    bodies=ModalRoute.of(context).settings.arguments;
    listNames();
    lightmode = MediaQuery.of(context).platformBrightness ==Brightness.light;
    return SafeArea(
      child: Scaffold(
        backgroundColor: lightmode?Colors.white:null,
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 0,
          backgroundColor: lightmode?Colors.white:null,
          title: Text(
            'Search',
            style: GoogleFonts.quicksand(
              color: Colors.deepPurpleAccent[100]
            ),
          ),
          leading: BackButton(color: Colors.deepPurpleAccent[100]),
        ),
        body: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    child: TextField(
                      controller: searchCont,
                      onChanged: (text){
                        if(text.length>=2){
                          searchName(text);
                        }
                        else{
                          this.setState(() {
                            searchResults.clear();
                          });
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: GoogleFonts.quicksand(color: Colors
                            .deepPurpleAccent[100]),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 0)
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 2, horizontal: 10),
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1,
                                color: Colors.deepPurpleAccent[100])),
                        fillColor: lightmode?Colors.grey[300]:Colors.grey[800],
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: lightmode?Colors.grey[300]:Colors.grey[850])),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: lightmode?Colors.grey[300]:Colors.grey[850])),
                        prefixIcon: Icon(Icons.search, color: Colors.deepPurpleAccent[100],),
                      ),
                      cursorHeight: 20,
                    ),
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  ),
                  Container(
                    child:Text(
                      'Search categories',
                      style: GoogleFonts.quicksand(
                        color: lightmode?Colors.blueGrey[900]:Colors.white,
                        fontSize: 18
                      ),
                    ) ,
                    margin: EdgeInsets.symmetric(vertical: 0,horizontal: 20),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        child: Text(
                          'All',
                          style: GoogleFonts.quicksand(
                            color: all?Colors.orangeAccent:null,
                            fontSize: 17
                          ),
                        ),
                        onPressed: (){
                          this.setState(() {
                            all=!all;
                          });
                        },
                      ),
                      TextButton(
                        child: Text(
                          'Planets',
                          style: GoogleFonts.quicksand(
                              color: planet?Colors.orangeAccent:null,
                              fontSize: 17
                          ),
                        ),
                        onPressed: (){
                          this.setState(() {
                            planet=!planet;
                          });
                        },
                      ),
                      TextButton(
                        child: Text(
                          'Moons',
                          style: GoogleFonts.quicksand(
                              color: moons?Colors.orangeAccent:null,
                              fontSize: 17
                          ),
                        ),
                        onPressed: (){
                          this.setState(() {
                            moons=!moons;
                          });
                        },
                      ),
                      TextButton(
                        child: Text(
                          'Asteroids',
                          style: GoogleFonts.quicksand(
                              color: asteroids?Colors.orangeAccent:null,
                              fontSize: 17
                          ),
                        ),
                        onPressed: (){
                          this.setState(() {
                            asteroids=!asteroids;
                          });
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                  (BuildContext context,int index){
                    return resultObject(index);
                  },
                childCount: this.searchResults.length
              ),
            )
          ],
        ),
      ),
    );
  }
  Container resultObject(int index){
    return Container(
      child: ListTile(
        title: Text(
          searchResults[index]['name'],
          style:GoogleFonts.quicksand(
            color: Colors.purpleAccent[100],
            fontSize: 20
          ),
        ),
        trailing: Text(
          searchResults[index]['type'],
          style: GoogleFonts.quicksand(
            color: Colors.purpleAccent[100],
            fontSize: 18
          ),
        ),
        subtitle: Text(
          'click to view info',
          style: GoogleFonts.quicksand(
            color: Colors.deepPurpleAccent[100]
          ),
        ),
        onTap: (){
          for(int i=0;i<bodies.length;i++){
            if(bodies[i]['englishName']==searchResults[index]['name']){
              if(searchResults[index]['type']=='planet')
                Navigator.pushNamed(context, '/planetinfo',arguments: {'data':bodies[i],'dp':mainPlanets.contains(searchResults[index]['name'].toLowerCase())?false:true});
              else if(searchResults[index]['type']=='moon')
                Navigator.pushNamed(context, '/mooninfo',arguments: {'data':bodies[i],'isUrl':false,'asteroid':false});
              else if(searchResults[index]['type']=='asteroid')
                Navigator.pushNamed(context, '/mooninfo',arguments: {'data':bodies[i],'isUrl':false,'asteroid':true});
              break;
            }
          }
        },
      ),
      margin: EdgeInsets.symmetric(vertical: 5,horizontal:5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: lightmode?Colors.grey[300]:Colors.grey[800]
      ),
    );
  }
}
