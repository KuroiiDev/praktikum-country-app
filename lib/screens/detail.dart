import 'package:flutter/material.dart';

import 'favorite.dart';
import 'home.dart';

class DetailPage extends StatefulWidget {
  final Country country;
  const DetailPage({super.key, required this.country});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    final isFav = FavoriteManager.isFavorite(widget.country);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.country.name),
        actions: [
          IconButton(
            icon: Icon(
              isFav ? Icons.star : Icons.star_border,
              color: isFav ? Colors.amber : null,
            ),
            tooltip: isFav ? 'Hapus dari Favorit' : 'Tambah ke Favorit',
            onPressed: () {
              setState(() {
                FavoriteManager.toggle(widget.country);
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.country.flagsPng != null)
              Center(
                child: Image.network(widget.country.flagsPng!, width: 200),
              ),
            const SizedBox(height: 16),
            Text(
              'Name: ${widget.country.name}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Capital: ${widget.country.capital ?? 'N/A'}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Region: ${widget.country.region}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Population: ${widget.country.population}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Languages: ${widget.country.languages?.join(', ') ?? 'N/A'}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Currencies: ${widget.country.currencies?.join(', ') ?? 'N/A'}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
