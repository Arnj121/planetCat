import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  Future initData()async {
    dynamic data={};
    dynamic url = Uri.parse("https://api.le-systeme-solaire.net/rest.php/knowncount");
    dynamic response = await http.get(
        url, headers: {"accept": "application/json"});
    if (response.statusCode == 200)
      data['count']=jsonDecode(response.body)['knowncount'];
    url = Uri.parse("https://api.le-systeme-solaire.net/rest.php/bodies");
    response = await http.get(
        url, headers: {"accept": "application/json"});
    if (response.statusCode == 200)
      data['bodies']=jsonDecode(response.body)['bodies'];
    Navigator.pushReplacementNamed(
        context, '/home', arguments: data);
  }

  @override void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    initData();
    return SafeArea(
      child: Scaffold(
        body: SpinKitFoldingCube(
          color: Colors.blueAccent,
          size: 50,
        ),
      ),
    );
  }
}
