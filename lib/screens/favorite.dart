import 'package:flutter/material.dart';

import 'detail.dart';
import 'home.dart';

class FavoriteManager {
  static final List<Country> favorites = [];

  static bool isFavorite(Country country) {
    return favorites.any((c) => c.name == country.name);
  }

  static void toggle(Country country) {
    if (isFavorite(country)) {
      favorites.removeWhere((c) => c.name == country.name);
    } else {
      favorites.insert(0, country);
    }
  }

  static void clear() {
    favorites.clear();
  }
}

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    final list = FavoriteManager.favorites;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorit'),
        actions: [
          if (list.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              tooltip: 'Hapus Semua Favorit',
              onPressed: () {
                setState(() {
                  FavoriteManager.clear();
                });
              },
            ),
        ],
      ),
      body: list.isEmpty
          ? const Center(child: Text('Belum ada negara favorit'))
          : ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, i) {
                final country = list[i];
                final isFav = FavoriteManager.isFavorite(country);
                return Card(
                  child: ListTile(
                    leading: country.flagsPng != null
                        ? Image.network(country.flagsPng!, width: 50)
                        : const SizedBox(width: 50),
                    title: Text(country.name),
                    subtitle: Text(country.region),
                    trailing: IconButton(
                      icon: Icon(
                        isFav ? Icons.star : Icons.star_border,
                        color: isFav ? Colors.amber : null,
                      ),
                      onPressed: () {
                        setState(() {
                          FavoriteManager.toggle(country);
                        });
                      },
                    ),
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
