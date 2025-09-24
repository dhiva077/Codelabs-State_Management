import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'global_state.dart';
import 'counter_tile.dart';

void main() {
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
    final globalState = Provider.of<GlobalState>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Global Counters'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => globalState.addCounter(),
          ),
        ],
      ),
          body: globalState.counters.isEmpty
        ? const Center(child: Text('Belum ada counter'))
        : ReorderableListView.builder(
            onReorder: (oldIndex, newIndex) =>
                globalState.reorder(oldIndex, newIndex),
            itemCount: globalState.counters.length,
            itemBuilder: (context, index) {
              return CounterTile(
                key: ValueKey('counter_$index'), // 👈 penting: key unik
                index: index,
              );
            },
          ),

    );
  }
}
