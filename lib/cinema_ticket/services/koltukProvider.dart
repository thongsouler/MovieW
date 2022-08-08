import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:movieapp/cinema_ticket/models/seat.dart';
import 'package:movieapp/cinema_ticket/services/firestore_service.dart';

class koltukProvider with ChangeNotifier {
  final firestoreService = FirestroeService();
  late bool _doluluk;
  late String _KoltukId;
  late String _SalonId;
  late String _KoltukNo;
  var uuid = Uuid();

  List<Koltuk> _todos = [];

  List<Koltuk> get todos => _todos.toList();

  List<Koltuk> get todosCompleted => _todos.toList();

  void setTodos(List<Koltuk> todos) =>
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        _todos = todos;
        notifyListeners();
      });
  set changeEntry(String entry) {
    _KoltukNo = entry;
    notifyListeners();
  }

  set changeDate(String KoltukId) {
    _KoltukId = KoltukId;
    notifyListeners();
  }
}
