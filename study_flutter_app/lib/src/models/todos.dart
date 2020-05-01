import 'package:study_flutter_app/src/models/todo.dart';

class Todos {
  final List<Todo> _items = <Todo>[];

  Todos();

  List<Todo> get items => _items;
  int get itemCount => _items.length;

  void addTodo(String _id, String _text) {
    _items.add(new Todo(_id, _text, false, new DateTime.now()));
  }

  void removeTodo(String _id) {
    for (int i = 0; i < _items.length; i++) {
      if (_items[i].id != _id) continue;
      _items.removeAt(i);
    }
  }

  void updateCompleted(String _id, bool _newValue) {
    _items.forEach((todo) {
      if (todo.id != _id) return;
      todo.isCompleted = _newValue;
    });
  }
}
