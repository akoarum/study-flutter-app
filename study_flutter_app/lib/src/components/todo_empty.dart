import 'package:flutter/material.dart';

class TodoEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: Center(
        child: Text(
          '何もありません',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
        ),
      ),
    );
  }
}
