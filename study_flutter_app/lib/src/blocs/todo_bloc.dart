import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:study_flutter_app/src/models/todo.dart';
import 'package:study_flutter_app/src/models/todos.dart';

class AddTodo {
  final String _id;
  final String _text;
  AddTodo(this._id, this._text);

  String get id => _id;
  String get text => _text;
}

class RemoveTodo {
  final String _id;
  RemoveTodo(this._id);
  String get id => _id;
}

class UpdateCompleted {
  final String _id;
  final bool _newValue;
  UpdateCompleted(this._id, this._newValue);
  String get id => _id;
  bool get newValue => _newValue;
}

class TodoBloc {
  final Todos _todos = Todos();
  final PublishSubject<List<Todo>> _items = PublishSubject<List<Todo>>();
  final StreamController<AddTodo> _addTodoController = StreamController<AddTodo>();
  final StreamController<RemoveTodo> _removeTodoController = StreamController<RemoveTodo>();
  final StreamController<UpdateCompleted> _updateCompletedContoller = StreamController<UpdateCompleted>();

  TodoBloc() {
    _addTodoController.stream.listen((addition) {
      _todos.addTodo(addition.id, addition.text);
      _items.add(_todos.items);
    });

    _removeTodoController.stream.listen((removal) {
      _todos.removeTodo(removal.id);
      _items.add(_todos.items);
    });

    _updateCompletedContoller.stream.listen((item) {
      _todos.updateCompleted(item.id, item.newValue);
      _items.add(_todos.items);
    });
  }

  Stream<List<Todo>> get todos => _items.stream;
  Sink<AddTodo> get addTodo => _addTodoController.sink;
  Sink<RemoveTodo> get removeTodo => _removeTodoController.sink;
  Sink<UpdateCompleted> get updateCompleted => _updateCompletedContoller.sink;

  void dispose() {
    _items.close();
    _addTodoController.close();
    _removeTodoController.close();
    _updateCompletedContoller.close();
  }
}
