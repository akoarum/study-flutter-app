import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';
import 'package:study_flutter_app/src/blocs/todo_bloc.dart';
import 'package:study_flutter_app/src/models/todo.dart';

var uuid = Uuid();

class TodoForm extends StatefulWidget {
  @override
  State createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  bool _isComposing = false;
  TextEditingController _textController = new TextEditingController();

  void addTodo(TodoBloc _bloc) {
    _bloc.addTodo.add(Todo(uuid.v4(), _textController.text, false, DateTime.now()));
    _textController.clear();

    setState(() {
      _isComposing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TodoBloc _bloc = Provider.of<TodoBloc>(context);
    return new Column(
      children: <Widget>[
        Divider(height: 1.0),
        new Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
          child: Row(
            children: <Widget>[
              Flexible(
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(hintText: 'ToDoを入力してください'),
                  onChanged: (String value) {
                    setState(() {
                      _isComposing = value.length > 0;
                    });
                  },
                ),
              ),
              RaisedButton(
                child: Text('追加する'),
                color: Colors.green,
                onPressed: () {
                  if (_isComposing) {
                    addTodo(_bloc);
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
