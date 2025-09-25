import 'package:flutter/material.dart';
import 'dart:math';

/// Model untuk satu counter
class CounterItem {
  int value; // Nilai counter
  Color color; // Warna counter
  String label; // Label counter

  CounterItem({
    this.value = 0, // Default nilai awal 0
    Color? color, // Warna opsional, jika tidak diberikan akan diacak
    String? label, // Label opsional, default 'Counter'
  })  : color = color ?? Colors.primaries[Random().nextInt(Colors.primaries.length)], // Menentukan warna secara acak jika tidak diberikan
        label = label ?? 'Counter'; // Menentukan label default
}

/// GlobalState untuk semua counter
class GlobalState extends ChangeNotifier {
  List<CounterItem> counters = []; // List untuk menyimpan semua counter

  /// Menambahkan counter baru ke list
  void addCounter() {
    counters.add(CounterItem()); // bikin item baru
    notifyListeners(); // Memberi tahu semua listener untuk refresh UI
  }
   /// Menambah nilai counter di index tertentu
  void increment(int index) {
    counters[index].value++; // Menambahkan 1 ke nilai counter
    notifyListeners();
  }

   /// Mengurangi nilai counter di index tertentu
  void decrement(int index) {
    counters[index].value--; // Mengurangi 1 dari nilai counter
    notifyListeners();
  }

  /// Menghapus counter di index tertentu
  void removeCounter(int index) {
    counters.removeAt(index); // Menghapus counter dari list
    notifyListeners();
  }

  /// Mengubah urutan counter dari oldIndex ke newIndex
  void reorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex--; // Koreksi index jika moving ke bawah
    final item = counters.removeAt(oldIndex); // Hapus item dari posisi lama
    counters.insert(newIndex, item); // Masukkan item ke posisi baru
    notifyListeners();
  }
}