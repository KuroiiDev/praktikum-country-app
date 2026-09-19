import 'package:flutter/material.dart';
import 'detail.dart';
import 'home.dart';

class HistoryManager {
  static final List<Country> history = [];

  static void add(Country country) {
    history.removeWhere((c) => c.name == country.name);
    history.insert(0, country);
  }

  static void clear() {
    history.clear();
  }
}

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    final list = HistoryManager.history;
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        actions: [
          if (list.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              tooltip: 'Hapus History',
              onPressed: () {
                setState(() {
                  HistoryManager.clear();
                });
              },
            ),
        ],
      ),
      body: list.isEmpty
          ? const Center(child: Text('Belum ada history negara yang dibuka'))
          : ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, i) {
                final country = list[i];
                return Card(
                  child: ListTile(
                    leading: country.flagsPng != null
                        ? Image.network(country.flagsPng!, width: 50)
                        : const SizedBox(width: 50),
                    title: Text(country.name),
                    subtitle: Text(country.region),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(country: country),
                        ),
                      );
                      setState(() {});
                    },
                  ),
                );
              },
            ),
    );
  }
}

