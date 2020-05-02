import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_flutter_app/src/blocs/todo_bloc.dart';

class TodoVisibleController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TodoBloc _bloc = Provider.of<TodoBloc>(context);
    return new StreamBuilder(
      stream: _bloc.isHideCompleted,
      builder: (_, snapshot) {
        return CheckboxListTile(
          activeColor: Colors.blue,
          title: Text('未対応のToDoのみ表示'),
          value: snapshot.data,
          onChanged: (bool newValue) {
            _bloc.updateHideCompleted.add(UpdateHideCompleted(newValue));
          },
        );
      },
    );
  }
}
