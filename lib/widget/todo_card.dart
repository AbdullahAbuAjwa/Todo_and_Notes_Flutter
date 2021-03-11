import 'package:flutter/material.dart';
import 'package:tood_and_note/ModelAndProvider/Todo.dart';
import 'package:tood_and_note/widget/todo_card_item.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class TodoCard extends StatefulWidget {
  @override
  _TodoCardState createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<TodoProvider>(context, listen: false).fetchTodo(),
      builder: (ctx, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Consumer<TodoProvider>(
              child: Center(
                child: Text(
                  DemoLocalizations.of(context).trans('no_items'),
                  style: TextStyle(fontSize: 22),
                ),
              ),
              builder: (context, todo, Widget child) => todo.items.length <= 0
                  ? child
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemCount: todo.items.length,
                      itemBuilder: (ctx, i) => Container(
                        child: TodoCardItem(
                          idTodo: todo.items[i].idTodo,
                          title: todo.items[i].title,
                          color: todo.items[i].color,
                        ),
                      ),
                    ),
            ),
    );
  }
}
