import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nameProvider =
    ChangeNotifierProvider<NameNotifier>((ref) => NameNotifier());

class NameNotifier extends ChangeNotifier {
  String name = '';

  void setName(String name) {
    this.name = name;
    notifyListeners();
  }
}
