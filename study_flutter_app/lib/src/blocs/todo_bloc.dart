import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:study_flutter_app/src/repository/db_provider.dart';
import 'package:study_flutter_app/src/models/todo.dart';

class UpdateHideCompleted {
  final bool _newValue;
  UpdateHideCompleted(this._newValue);
  bool get newValue => _newValue;
}

class TodoBloc {
  final PublishSubject<List<Todo>> _items = PublishSubject<List<Todo>>();
  final BehaviorSubject<bool> _isHideCompleted = BehaviorSubject<bool>();
  final StreamController<UpdateHideCompleted> _updateHideCompleted = StreamController<UpdateHideCompleted>();
  final StreamController<Todo> _addTodoController = StreamController<Todo>();
  final StreamController<Todo> _removeTodoController = StreamController<Todo>();
  final StreamController<Todo> _updateTodoContoller = StreamController<Todo>();

  getTodos() async {
    _items.add(await DBProvider.db.getAllTodos());
  }

  TodoBloc() {
    _isHideCompleted.add(false);

    getTodos();

    _updateHideCompleted.stream.listen((update) {
      _isHideCompleted.add(update.newValue);
    });

    _addTodoController.stream.listen((todo) {
      DBProvider.db.createTodo(todo);
      getTodos();
    });

    _removeTodoController.stream.listen((todo) {
      DBProvider.db.deleteTodo(todo.id);
      getTodos();
    });

    _updateTodoContoller.stream.listen((todo) {
      DBProvider.db.updateTodo(todo);
      getTodos();
    });
  }

  Stream<List<Todo>> get todos => _items.stream;
  Stream<bool> get isHideCompleted => _isHideCompleted.stream;
  Sink<UpdateHideCompleted> get updateHideCompleted => _updateHideCompleted.sink;
  Sink<Todo> get addTodo => _addTodoController.sink;
  Sink<Todo> get removeTodo => _removeTodoController.sink;
  Sink<Todo> get updateCompleted => _updateTodoContoller.sink;

  void dispose() {
    _items.close();
    _isHideCompleted.close();
    _updateHideCompleted.close();
    _addTodoController.close();
    _removeTodoController.close();
    _updateTodoContoller.close();
  }
}
