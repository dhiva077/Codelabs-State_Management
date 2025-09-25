import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'global_state.dart';
import 'counter_tile.dart';

void main() {
   // Entry point aplikasi Flutter
  // Membungkus aplikasi dengan ChangeNotifierProvider untuk menyediakan GlobalState secara global
  runApp(
    ChangeNotifierProvider(
      create: (_) => GlobalState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp sebagai root widget aplikasi
    // debugShowCheckedModeBanner dimatikan agar tidak muncul label debug
    // home menampilkan halaman utama CounterListScreen
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const CounterListScreen(),
    );
  }
}

class CounterListScreen extends StatelessWidget {
  const CounterListScreen({super.key});

  @override
  Widget build(BuildContext context) {
     // Mengambil instance GlobalState dari Provider untuk digunakan di widget ini
    final globalState = Provider.of<GlobalState>(context);

    return Scaffold(
       // Scaffold menyediakan struktur dasar halaman, termasuk AppBar dan body
      appBar: AppBar(
        title: const Text('Global Counters'),
         // Tombol '+' di AppBar untuk menambahkan counter baru
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => globalState.addCounter(),
          ),
        ],
      ),
       // Body menampilkan daftar counter atau teks jika kosong
          body: globalState.counters.isEmpty
        ? const Center(child: Text('Belum ada counter'))
        : ReorderableListView.builder(
            onReorder: (oldIndex, newIndex) =>
                globalState.reorder(oldIndex, newIndex),
            itemCount: globalState.counters.length,
            itemBuilder: (context, index) {
              return CounterTile(
                key: ValueKey('counter_$index'),
                index: index,
              );
            },
          ),

    );
  }
}
