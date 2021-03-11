import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tood_and_note/ModelAndProvider/Note.dart';

import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../main.dart';

class NoteItemCard extends StatefulWidget {
  var id;
  var isFav;
  var title;
  var time;
  var text;

  NoteItemCard({Key key, this.id, this.isFav, this.title, this.time, this.text})
      : super(key: key);

  @override
  _NoteItemCardState createState() => _NoteItemCardState();
}

class _NoteItemCardState extends State<NoteItemCard> {
  bool fav;

  @override
  void initState() {
    fav = widget.isFav == 0 ? false : true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.id),
      direction: DismissDirection.horizontal,
      background: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).padding.top + 8),
        child: Container(
          child: Icon(
            Icons.delete,
            color: Colors.black,
            size: 35,
          ),
          color: Colors.red,
        ),
      ),
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(
              DemoLocalizations.of(context).trans('are_you_sure'),
              style: TextStyle(fontSize: 20.sp),
            ),
            content: Text(
              DemoLocalizations.of(context).trans('delete_note'),
              style: TextStyle(fontSize: 16.sp),
            ),
            actions: <Widget>[
              TextButton(
                  child: Text(
                    DemoLocalizations.of(context).trans('cancel'),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  }),
              TextButton(
                  child: Text(DemoLocalizations.of(context).trans('yes'),
                      style: TextStyle(
                        color: Colors.red,
                      )),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  }),
            ],
          ),
        );
      },
      onDismissed: (item) {
        Provider.of<NoteProvider>(context, listen: false).removeItem(widget.id);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            DemoLocalizations.of(context).trans('delete_success'),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          duration: const Duration(seconds: 2),
        ));
      },
      child: Hero(
        tag: widget.id,
        transitionOnUserGestures: true,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).padding.top + 4,
              horizontal: MediaQuery.of(context).padding.left + 4),
          child: Card(
            child: Container(
              color: Theme.of(context).cardColor,
              child: ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    'move_to_note_details',
                    arguments: widget.id,
                  );
                },
                leading: IconButton(
                  icon: Icon(
                    fav ? Icons.star : Icons.star_border,
                    color: Colors.red,
                    size: 27.sp,
                  ),
                  onPressed: () {
                    setState(() {
                      Provider.of<NoteProvider>(context, listen: false)
                          .updateFavNote(widget.id, widget.isFav);
                      fav = !fav;
                    });
                  },
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Colors.black,
                    size: 27.sp,
                  ),
                  onPressed: () {
                    editNoteDialog(context);
                  },
                ),
                title: Text(
                  widget.title,
                  style: GoogleFonts.artifika(),
                ),
                subtitle: Text(widget.time),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<String> editNoteDialog(BuildContext context) async {
    String title = widget.title;
    String text = widget.text;
    final _formKey = GlobalKey<FormState>();

    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: Text(
              DemoLocalizations.of(context).trans('edit_note'),
              style: TextStyle(fontSize: 20.sp),
            ),
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
                    decoration: InputDecoration(
                      labelText:
                          DemoLocalizations.of(context).trans('enter_title'),
                    ),
                    onChanged: (data) {
                      title = data;
                    },
                  ),
                  Container(
                    //  height: 150,
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
                      decoration: InputDecoration(
                        labelText:
                            DemoLocalizations.of(context).trans('enter_text'),
                        hintText: DemoLocalizations.of(context).trans('text'),
                      ),
                      textAlign: TextAlign.start,
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
                          Provider.of<NoteProvider>(context, listen: false)
                              .updateInfoNote(
                                  widget.id, title.trim(), text.trim());
                          widget.title = title;
                          widget.text = text;
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
  }
}
