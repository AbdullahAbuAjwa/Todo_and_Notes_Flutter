import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tood_and_note/ModelAndProvider/Note.dart';
import 'package:tood_and_note/widget/note_details.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../main.dart';

class NoteDetailsScreen extends StatefulWidget {
  @override
  _NoteDetailsScreenState createState() => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends State<NoteDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final noteId = ModalRoute.of(context).settings.arguments as String;
    final information = Provider.of<NoteProvider>(context).findByID(noteId);
    // bool star = information.isFav == 0 ? false : true;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          information.title,
          style: TextStyle(fontSize: 22.sp),
        ),
        actions: <Widget>[
          /*  IconButton(
            icon: Icon(star ? Icons.star : Icons.star_border),
            onPressed: () {
              // setState(() {
              //   Provider.of<NoteProvider>(context, listen: false)
              //       .updateFavNote(noteId, information.isFav);
              //   star = !star;
              // });
            },
          ),*/
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              final _formKey = GlobalKey<FormState>();
              String title = information.title;
              String text = information.text;
              return showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return SingleChildScrollView(
                    child: AlertDialog(
                      title: Text(
                          DemoLocalizations.of(context).trans('edit_note')),
                      content: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            TextFormField(
                              initialValue: title,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return DemoLocalizations.of(context)
                                      .trans('please_enter_title');
                                }
                                return null;
                              },
                              onChanged: (data) {
                                title = data;
                              },
                            ),
                            Container(
                              child: TextFormField(
                                initialValue: text,
                                maxLines: 10,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return DemoLocalizations.of(context)
                                        .trans('please_enter_text');
                                  }
                                  return null;
                                },
                                textAlign: TextAlign.start,
                                autofocus: true,
                                onChanged: (data) {
                                  text = data;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TextButton(
                              child: Text(
                                DemoLocalizations.of(context).trans('cancel'),
                                style: TextStyle(color: Colors.red),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text(
                                DemoLocalizations.of(context).trans('save'),
                                style: TextStyle(color: Colors.blue),
                              ),
                              onPressed: () {
                                setState(() {
                                  if (_formKey.currentState.validate()) {
                                    Provider.of<NoteProvider>(context,
                                            listen: false)
                                        .updateInfoNote(
                                            noteId, title.trim(), text.trim());
                                    information.title = title;
                                    information.text = text;
                                    Navigator.of(context).pop();
                                  }
                                });
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              deleteNote(context, noteId);
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              final RenderBox box = context.findRenderObject();
              Share.share(information.title + '\n' + information.text,
                  sharePositionOrigin:
                      box.localToGlobal(Offset.zero) & box.size);
            },
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        child: Hero(
          transitionOnUserGestures: true,
          tag: information.id,
          child: NoteDetails(
            information.title,
            information.text,
            information.dateTime,
          ),
        ),
      ),
    );
  }

  Future<void> deleteNote(BuildContext context, String id) async {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          DemoLocalizations.of(context).trans('are_you_sure'),
        ),
        content: Text(
          DemoLocalizations.of(context).trans('delete_note'),
        ),
        actions: <Widget>[
          TextButton(
              child: Text(
                DemoLocalizations.of(context).trans('cancel'),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          TextButton(
              child: Text(DemoLocalizations.of(context).trans('yes'),
                  style: TextStyle(color: Colors.red)),
              onPressed: () {
                Provider.of<NoteProvider>(context, listen: false)
                    .removeItem(id);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }),
        ],
      ),
    );
  }
}
