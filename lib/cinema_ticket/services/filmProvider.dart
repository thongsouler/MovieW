import 'package:flutter/material.dart';
import 'package:movieapp/cinema_ticket/models/Film.dart';


class filmProvider with ChangeNotifier {
  List<Film> _todos = [];

  List<Film> get todos => _todos.toList();

  List<Film> get todosCompleted => _todos.toList();

  void setTodos(List<Film> todos) =>
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        _todos = todos;
        notifyListeners();
      });
}
