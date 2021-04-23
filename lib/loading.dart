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
    print('started');
    dynamic url = Uri.parse("https://api.le-systeme-solaire.net/rest.php/knowncount");
    print(url);
    dynamic response = await http.get(
        url, headers: {"accept": "application/json"});
    if (response.statusCode == 200) {
      Navigator.pushReplacementNamed(
          context, '/home', arguments: jsonDecode(response.body)['knowncount']);
    }
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
