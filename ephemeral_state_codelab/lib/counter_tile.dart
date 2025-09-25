import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'global_state.dart';

class CounterTile extends StatelessWidget {
  final int index; // Index counter di list global
  const CounterTile({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    // Mengambil instance GlobalState dari Provider
    final globalState = Provider.of<GlobalState>(context);
    // Mengambil counter sesuai index
    final counter = globalState.counters[index];

    return Card(
      color: counter.color.withOpacity(0.3), // Memberikan warna background card dengan transparansi
      key: ValueKey(counter),
      child: ListTile(
        title: Text('${counter.label} ${index + 1}: ${counter.value}'), // Menampilkan label dan nilai counter
        trailing: Wrap(
          spacing: 4,
          children: [
            // Tombol decrement
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () => globalState.decrement(index), // Memanggil method decrement di GlobalState
            ),
            // Tombol increment
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => globalState.increment(index), // Memanggil method increment di GlobalState
            ),
            // Tombol ubah warna
            IconButton(
              icon: const Icon(Icons.color_lens),
              onPressed: () {
                // Mengubah warna counter berdasarkan index dan waktu saat ini
                counter.color = Colors.primaries[
                    (index + DateTime.now().second) %
                        Colors.primaries.length];
                globalState.notifyListeners();
              },
            ),
            // Tombol edit label
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                final controller = TextEditingController(text: counter.label);
                // Menampilkan dialog untuk edit label
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
                      // Tombol batal
                      TextButton(
                        onPressed: () => Navigator.pop(context), // Menutup dialog
                        child: const Text('Batal'),
                      ),
                      // Tombol simpan
                      ElevatedButton(
                        onPressed: () {
                          counter.label = controller.text; // Mengubah label counter
                          globalState.notifyListeners();
                          Navigator.pop(context); // Menutup dialog
                        },
                        child: const Text('Simpan'),
                      ),
                    ],
                  ),
                );
              },
            ),
            // Tombol hapus counter
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => globalState.removeCounter(index), // Memanggil method removeCounter di GlobalState
            ),
          ],
        ),
      ),
    );
  }
}
