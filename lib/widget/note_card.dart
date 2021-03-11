import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tood_and_note/ModelAndProvider/Note.dart';
import 'package:provider/provider.dart' as prov;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../main.dart';
import 'note_card_item.dart';

class NoteCard extends StatefulWidget {
  @override
  _NoteCardState createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          prov.Provider.of<NoteProvider>(context, listen: false).fetchNotes(),
      builder: (ctx, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
          ? Center(
              child: CircularProgressIndicator(),
            )
          : prov.Consumer<NoteProvider>(
              child: Center(
                child: Text(
                  DemoLocalizations.of(context).trans('no_items'),
                  style: TextStyle(fontSize: 22.sp),
                ),
              ),
              builder: (context, notes, Widget child) => notes.items.length <= 0
                  ? child
                  : ListView.builder(
                      itemCount: notes.items.length,
                      itemBuilder: (ctx, i) => Container(
                        child: NoteItemCard(
                          id: notes.items[i].id,
                          title: notes.items[i].title,
                          isFav: notes.items[i].isFav,
                          time: notes.items[i].dateTime,
                          text: notes.items[i].text,
                        ),
                      ),
                    ),
            ),
    );
  }
}

class NoteFavCard extends StatefulWidget {
  @override
  _NoteFavCardState createState() => _NoteFavCardState();
}

class _NoteFavCardState extends State<NoteFavCard> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: prov.Provider.of<NoteProvider>(context, listen: false)
          .fetchFavNotes(),
      builder: (ctx, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
          ? Center(
              child: CircularProgressIndicator(),
            )
          : prov.Consumer<NoteProvider>(
              child: Center(
                child: Text(
                  DemoLocalizations.of(context).trans('no_items'),
                  style: TextStyle(fontSize: 22.sp),
                ),
              ),
              builder: (context, notes, Widget child) => notes.items.length <= 0
                  ? child
                  : ListView.builder(
                      itemCount: notes.items.length,
                      itemBuilder: (ctx, i) => Container(
                          child: NoteItemCard(
                        id: notes.items[i].id,
                        title: notes.items[i].title,
                        isFav: notes.items[i].isFav,
                        time: notes.items[i].dateTime,
                        text: notes.items[i].text,
                      )),
                    ),
            ),
    );
  }
}
