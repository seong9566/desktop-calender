import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel._();
  static final HomeViewModel _instance = HomeViewModel._();

  factory HomeViewModel() {
    return _instance;
  }

  int selectedIndex = 0;

  void update() {
    notifyListeners();
  }

  void movePage(int index) {
    selectedIndex = index;
    update();
  }
}
