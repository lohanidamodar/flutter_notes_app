import 'package:flutter/material.dart';
import 'package:flutter_notes_app/model/note.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NoteItem extends StatelessWidget {
  final Note note;
  final Function(Note) onEdit;
  final Function(Note) onDelete;
  final Function(Note) onTap;
  const NoteItem({Key key, @required this.note, @required this.onEdit, @required this.onDelete, @required this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0,),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        secondaryActions: <Widget>[
      IconSlideAction(
        caption: 'Edit',
        color: Colors.blue,
        icon: Icons.edit,
        onTap: () => onEdit(note),
      ),
      IconSlideAction(
        caption: 'Delete',
        color: Colors.red,
        icon: Icons.delete,
        onTap: () => onDelete(note),
      ),
  ],
        child: ListTile(
          onTap: () => onTap(note),
          title: Text(note.title),
        ),
      ),
    );
  }
}