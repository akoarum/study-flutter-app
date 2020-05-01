import 'package:flutter/material.dart';
import 'package:study_flutter_app/src/screen/home.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData.light(),
      home: Home(),
    );
  }
}
