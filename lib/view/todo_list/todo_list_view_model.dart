import 'package:flutter/material.dart';
import 'package:windows_calender_app/model/todo_model.dart';

class TodoListViewModel extends ChangeNotifier {
  TodoListViewModel._();
  static final TodoListViewModel _instance = TodoListViewModel._();

  factory TodoListViewModel() {
    return _instance;
  }

  List<TodoModel> todoList = [
    TodoModel(
        "배 정비", "프로펠러 정비", "3시간", "김재성", "2024.03.26", "2024.03.27", false),
    TodoModel(
        "레크레이션", "노래틀기 ", "1시간", "김재성", "2024.03.27", "2024.03.22", false),
  ];

  void update() {
    notifyListeners();
  }

  void selectLateDate(int index, String date) {
    todoList[index].lateDate = date;
    print("todoList[index].lateDate: ${todoList[index].lateDate}");
    update();
  }
}
