import 'package:flutter/material.dart';
import 'package:flutter_notes_app/model/note.dart';

class NoteDetailsPage extends StatelessWidget {
  final Note note;

  const NoteDetailsPage({Key key, @required this.note}) : super(key: key);
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Note details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(note.title, style: Theme.of(context).textTheme.title,),
            const SizedBox(height: 10.0),
            Text(note.description, style: Theme.of(context).textTheme.body1,),
          ],
        ),
      ),
    );
  }
}