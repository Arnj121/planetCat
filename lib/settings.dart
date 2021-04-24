import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  bool lightmode=true;

  @override
  Widget build(BuildContext context) {
    lightmode = MediaQuery.of(context).platformBrightness ==Brightness.light;
    return SafeArea(
      child: Scaffold(
        backgroundColor:lightmode?CupertinoColors.white:null,
        appBar: AppBar(
          backgroundColor: lightmode?Colors.white:null,
          title: Text(
            'Settings',
            style: GoogleFonts.openSans(),
          ),
          titleSpacing: 0,
        ),
      ),
    );
  }
}
