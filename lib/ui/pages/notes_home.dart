import 'package:flutter/material.dart';
import 'package:flutter_notes_app/model/user_repository.dart';
import 'package:provider/provider.dart';

class NotesHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Notes"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => Provider.of<UserRepository>(context).signOut(),
          ),
        ],
      ),
      body: Center(
        child: Text("Notes application in flutter."),
      ),
    );
  }

}