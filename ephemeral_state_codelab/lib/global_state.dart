import 'package:flutter/material.dart';
import 'dart:math';

/// Model untuk satu counter
class CounterItem {
  int value;
  Color color;
  String label;

  CounterItem({
    this.value = 0,
    Color? color,
    String? label,
  })  : color = color ?? Colors.primaries[Random().nextInt(Colors.primaries.length)],
        label = label ?? 'Counter';
}

/// GlobalState untuk semua counter
class GlobalState extends ChangeNotifier {
  List<CounterItem> counters = [];

  void addCounter() {
    counters.add(CounterItem()); // bikin item baru
    notifyListeners();
  }

  void increment(int index) {
    counters[index].value++;
    notifyListeners();
  }

  void decrement(int index) {
    counters[index].value--;
    notifyListeners();
  }

  void removeCounter(int index) {
    counters.removeAt(index);
    notifyListeners();
  }

  void reorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex--;
    final item = counters.removeAt(oldIndex);
    counters.insert(newIndex, item);
    notifyListeners();
  }
}