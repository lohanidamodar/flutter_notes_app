import 'package:flutter/material.dart';
import 'package:flutter_notes_app/model/note.dart';
import 'package:flutter_notes_app/model/user_repository.dart';
import 'package:flutter_notes_app/service/db_service.dart';
import 'package:provider/provider.dart';

class AddNotePage extends StatefulWidget {
  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  TextEditingController _titleController;
  TextEditingController _descriptionController;
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  FocusNode _descriptionNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _descriptionNode = FocusNode();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text('Add note'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: "enter title",
              ),
              textInputAction: TextInputAction.next,
              onEditingComplete: (){
                FocusScope.of(context).requestFocus(_descriptionNode);
              },
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: _descriptionController,
              focusNode: _descriptionNode,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: "enter description",
              ),
            ),
            const SizedBox(height: 10.0),
            RaisedButton(
              child: Text("Save"),
              onPressed: ()async {
                if(_titleController.text.isEmpty) {
                  _key.currentState.showSnackBar(SnackBar(
                    content: Text("Title is required."),
                  ));
                  return;
                }
                Note note = Note(
                  title: _titleController.text,
                  description: _descriptionController.text,
                  createdAt: DateTime.now(),
                  userId: Provider.of<UserRepository>(context).user.uid,
                );
                await notesDb.createItem(note);
                /* _key.currentState.showSnackBar(SnackBar(
                  content: Text("Notes saved successfully")
                )); */
                Navigator.pop(context);
                /* FocusScope.of(context).requestFocus(FocusNode());
                _titleController.clear();
                _descriptionController.clear(); */
              },
            )
          ],
        ),
      ),
    );
  }
}