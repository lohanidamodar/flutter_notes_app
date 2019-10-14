import 'package:flutter/material.dart';
import 'package:flutter_notes_app/ui/pages/auth/login.dart';

import 'ui/pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Notes',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.lightGreen,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0,)
        ),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(16.0,),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          labelStyle: TextStyle(
            fontSize: 18.0,
            color: Colors.grey.shade600,
          ),
        )
      ),
      home: LoginPage(),
    );
  }
}
