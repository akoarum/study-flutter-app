import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_flutter_app/src/blocs/todo_bloc.dart';
import 'package:study_flutter_app/src/components/todo_list.dart';
import 'package:study_flutter_app/src/components/todo_visible_controller.dart';
import 'package:study_flutter_app/src/components/todo_form.dart';

class Home extends StatefulWidget {
  @override
  State createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  TodoBloc todoBloc = new TodoBloc();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text('ToDo List')),
      body: Provider(
        create: (context) => TodoBloc(),
        child: Column(
          children: <Widget>[
            TodoVisibleController(),
            Divider(height: 1.0),
            TodoList(),
            TodoForm(),
          ],
        ),
        dispose: (_, value) => value.dispose(),
      ),
    );
  }
}
