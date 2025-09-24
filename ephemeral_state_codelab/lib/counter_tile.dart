import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'global_state.dart';

class CounterTile extends StatelessWidget {
  final int index;
  const CounterTile({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final globalState = Provider.of<GlobalState>(context);
    final counter = globalState.counters[index];

    return Card(
      color: counter.color.withOpacity(0.3),
      key: ValueKey(counter),
      child: ListTile(
        title: Text('${counter.label} ${index + 1}: ${counter.value}'),
        trailing: Wrap(
          spacing: 4,
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () => globalState.decrement(index),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => globalState.increment(index),
            ),
            IconButton(
              icon: const Icon(Icons.color_lens),
              onPressed: () {
                counter.color = Colors.primaries[
                    (index + DateTime.now().second) %
                        Colors.primaries.length];
                globalState.notifyListeners();
              },
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                final controller = TextEditingController(text: counter.label);
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Edit Label'),
                    content: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        labelText: 'Label baru',
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Batal'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          counter.label = controller.text;
                          globalState.notifyListeners();
                          Navigator.pop(context);
                        },
                        child: const Text('Simpan'),
                      ),
                    ],
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => globalState.removeCounter(index),
            ),
          ],
        ),
      ),
    );
  }
}
