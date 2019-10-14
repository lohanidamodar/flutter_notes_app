import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Notes"),
      ),
      body: Center(
        child: Text("Notes application in flutter."),
      ),
    );
  }

}