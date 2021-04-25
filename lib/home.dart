import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  dynamic astroBodiesCount = [];bool lightmode=true,search=false;
  dynamic astroBodies = [];

  @override
  Widget build(BuildContext context) {
    dynamic temp = ModalRoute.of(context).settings.arguments;
    astroBodiesCount=temp['count'];astroBodies=temp['bodies'];
    lightmode = MediaQuery.of(context).platformBrightness ==Brightness.light;
    return SafeArea(
      child: Scaffold(
        backgroundColor: lightmode?Colors.white:null,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: lightmode?Colors.white:null,
          title: Text(
            'Catalogue',
            style: GoogleFonts.bangers(
              color: Colors.deepPurpleAccent[100],
              letterSpacing: 2,
              fontSize: 25
            ),
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.deepPurpleAccent[100],
                ),
                onPressed: (){Navigator.pushNamed(context,'/search',arguments: astroBodies);}
            )
          ],
          centerTitle: true,
        ),
        body: CustomScrollView(
          slivers: [
            SliverList(delegate: SliverChildListDelegate([SizedBox(height: 30,)])),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 5
              ),
              delegate: SliverChildListDelegate(
                  [
                    Container(
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('./assets/planet.jpg',),
                                ),
                                borderRadius: BorderRadius.circular(5)
                              ),
                              margin: EdgeInsets.all(0),
                            ),
                            Center(
                              child: ListTile(
                                onTap: (){Navigator.pushNamed(context, '/planets',arguments: astroBodies);},
                                title: Center(
                                  child: Text(
                                    'Planets',
                                    style: GoogleFonts.quicksand(
                                      color: Colors.white,
                                      fontSize: 25
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                        ),
                        margin: EdgeInsets.symmetric(vertical: 0,horizontal: 5),
                    ),
                    Container(
                      child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage('./assets/moon.jpg',),
                                  ),
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              margin: EdgeInsets.all(0),
                            ),
                            Center(
                              child: ListTile(
                                onTap: (){Navigator.pushNamed(context, '/moons',arguments: astroBodies);},
                                title: Center(
                                  child: Text(
                                    'Moons',
                                    style: GoogleFonts.quicksand(
                                        color: Colors.white,
                                        fontSize: 25
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 0,horizontal: 5),
                    ),
                    Container(
                      child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage('./assets/pluto.jpg',),
                                  ),
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              margin: EdgeInsets.all(0),
                            ),
                            Center(
                              child: ListTile(
                                onTap: (){Navigator.pushNamed(context, '/dwarf',arguments: astroBodies);},
                                title: Center(
                                  child: Text(
                                    'Dwarf Planets',
                                    style: GoogleFonts.quicksand(
                                        color: Colors.white,
                                        fontSize: 25
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 0,horizontal: 5),
                    ),
                    Container(
                      child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage('./assets/asteroid.jpg',),
                                  ),
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              margin: EdgeInsets.all(0),
                            ),
                            Center(
                              child: ListTile(
                                onTap: (){Navigator.pushNamed(context, '/asteroid',arguments: astroBodies);},
                                title: Center(
                                  child: Text(
                                    'Asteroids',
                                    style: GoogleFonts.quicksand(
                                        color: Colors.white,
                                        fontSize: 25
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 0,horizontal: 5),
                    ),
                  ]
              ),
            ),
            SliverList(
                delegate:SliverChildListDelegate(
                      [
                        SizedBox(height: 20,),
                        Container(
                        child: Row(
                          children: [
                            Text(
                              'Categories',
                              style: GoogleFonts.quicksand(
                                  color: Colors.purpleAccent,
                                  fontSize: 20
                              ),
                            ),
                            SizedBox(width: 10,),
                            CircleAvatar(
                              child: Text(
                                this.astroBodiesCount.length.toString(),
                                style: GoogleFonts.quicksand(
                                    color: Colors.blueGrey[800]
                                ),
                              ),
                              backgroundColor: Colors.white,
                              maxRadius: 10,
                            )
                          ],
                        ),
                        margin: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                      )
                    ]
                )
            ),
            SliverList(
              delegate:SliverChildBuilderDelegate(
                  (BuildContext context,int index){
                    return bodyObj(index);
                  },
                childCount: astroBodiesCount.length
              )
            )
          ],
        ),
      ),
    );
  }
  Container bodyObj(int index){
    return Container(
      child: ListTile(
        title: Text(
          this.astroBodiesCount[index]['id'],
          style: GoogleFonts.quicksand(
            fontSize: 20,
            color: Colors.blueGrey[800]
          ),
        ),
        trailing: Text(
          this.astroBodiesCount[index]['knownCount'].toString(),
          style: GoogleFonts.quicksand(
            color: Colors.blueGrey[900],
            fontSize: 20
          ),
        ),
        subtitle: Text(
          'Last Updated : '+this.astroBodiesCount[index]['updateDate'],
          style: GoogleFonts.quicksand(
            color: Colors.grey[100]
          ),
        ),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.deepPurpleAccent[100],
        borderRadius:BorderRadius.circular(5)
      ),
    );
  }
}
