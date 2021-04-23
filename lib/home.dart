import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController searchCont = TextEditingController();
  dynamic Bodies = [];
  @override
  Widget build(BuildContext context) {
    Bodies = ModalRoute.of(context).settings.arguments;
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(
                'Catalogue',
                style: GoogleFonts.openSans(
                  color: Colors.deepPurpleAccent[100]
                ),
              ),
              actions: [
                IconButton(
                    icon: Icon(
                      Icons.settings,
                      color: Colors.deepPurpleAccent[100],
                    ),
                    onPressed: (){}
                )
              ],
              centerTitle: true,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                    [
                      Container(
                      child: TextField(
                        controller: searchCont,
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: GoogleFonts.openSans(color: Colors
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
                          fillColor: Colors.grey[800],
                          disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Colors.grey[850])),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Colors.grey[850])),
                          prefixIcon: Icon(Icons.search, color: Colors
                              .deepPurpleAccent[100],),
                        ),
                        cursorHeight: 20,
                        ),
                        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      ),
                      SizedBox(height: 20,),
                      Visibility(
                        visible: true,
                        child: Container(
                          child: Row(
                            children: [
                              Text(
                                'Categories',
                                style: GoogleFonts.openSans(
                                  color: Colors.purpleAccent,
                                  fontSize: 20
                                ),
                              ),
                              SizedBox(width: 10,),
                              CircleAvatar(
                                child: Text(
                                  this.Bodies.length.toString(),
                                  style: GoogleFonts.openSans(
                                    color: Colors.blueGrey[800]
                                  ),
                                ),
                                backgroundColor: Colors.white,
                                maxRadius: 10,
                              )
                            ],
                          ),
                          margin: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                        ),
                      ),
                      SizedBox(height: 20,),
                    ],
              ),
            ),
            SliverList(
              delegate:SliverChildBuilderDelegate(
                  (BuildContext context,int index){
                    return BodyObj(index);
                  },
                childCount: Bodies.length
              )
            )
          ],
        ),
      ),
    );
  }
  Container BodyObj(int index){
    return Container(
      child: ListTile(
        onTap: (){},
        title: Text(
          this.Bodies[index]['id'],
          style: GoogleFonts.openSans(
            fontSize: 20,
            color: Colors.blueGrey[800]
          ),
        ),
        trailing: Text(
          this.Bodies[index]['knownCount'].toString(),
          style: GoogleFonts.openSans(
            color: Colors.blueGrey[900]
          ),
        ),
        subtitle: Text(
          'Last Updated : '+this.Bodies[index]['updateDate'],
          style: GoogleFonts.openSans(
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
