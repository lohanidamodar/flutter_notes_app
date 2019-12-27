import 'package:flutter/material.dart';
import 'package:flutter_notes_app/model/note.dart';
import 'package:flutter_notes_app/model/user_repository.dart';
import 'package:flutter_notes_app/service/db_service.dart';
import 'package:provider/provider.dart';

class AddNotePage extends StatefulWidget {
  final Note note;

  const AddNotePage({Key key, this.note}) : super(key: key);
  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  TextEditingController _titleController;
  TextEditingController _descriptionController;
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  FocusNode _descriptionNode;
  bool _editMode;
  bool _processing;
  @override
  void initState() {
    super.initState();
    _processing=false;
    _editMode = widget.note != null;
    _titleController = TextEditingController( text:  _editMode ? widget.note.title : null);
    _descriptionController = TextEditingController(text:  _editMode ? widget.note.description : null);
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
              child: _processing ? CircularProgressIndicator() : Text("Save"),
              onPressed: _processing ? null  : ()async {
                setState(() {
                  _processing = true;
                });
                if(_titleController.text.isEmpty) {
                  _key.currentState.showSnackBar(SnackBar(
                    content: Text("Title is required."),
                  ));
                  return;
                }
                Note note = Note(
                  id: _editMode ? widget.note.id : null,
                  title: _titleController.text,
                  description: _descriptionController.text,
                  createdAt: DateTime.now(),
                  userId: Provider.of<UserRepository>(context).user.uid,
                );
                if(_editMode) {
                  await notesDb.updateItem(note);
                }else {
                  await notesDb.createItem(note);
                }
                setState(() {
                  _processing = false;
                });
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