import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_flutter_app/src/blocs/todo_bloc.dart';
import 'package:study_flutter_app/src/components/todo_empty.dart';

class TodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TodoBloc _bloc = Provider.of<TodoBloc>(context);

    return new StreamBuilder<bool>(
      stream: _bloc.isHideCompleted,
      builder: (_, hideCompleted) {
        return new StreamBuilder<List>(
          stream: _bloc.todos,
          builder: (_, snapshot) {
            if (!snapshot.hasData || snapshot.data.isEmpty) return TodoEmpty();
            final todos = snapshot.data.where((todo) {
              if (!hideCompleted.data) return true;
              return !todo.isCompleted;
            });
            final _tiles = todos.map((todo) {
              return new Column(
                children: <Widget>[
                  Dismissible(
                    key: Key(todo.id),
                    onDismissed: (direction) {
                      _bloc.removeTodo.add(RemoveTodo(todo.id));
                    },
                    background: Container(color: Colors.red),
                    child: ListTile(
                      title: Text(todo.text),
                      subtitle: Text(todo.isCompleted ? 'Done' : 'Not yet'),
                      onTap: () {
                        _bloc.updateCompleted.add(UpdateCompleted(todo.id, !todo.isCompleted));
                      },
                    ),
                  ),
                  Divider(
                    height: 1.0,
                  ),
                ],
              );
            }).toList();

            return Flexible(
              child: ListView(
                children: _tiles,
              ),
            );
          },
        );
      }
    );
  }
}
