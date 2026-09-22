import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:io';

import 'detail.dart';
import 'favorite.dart';
import 'history.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Country>> countries;
  bool isByRegion = false;

  @override
  void initState() {
    super.initState();
    countries = fetchCountries();
  }

  Future<List<Country>> fetchCountries() async {
    final uri = Uri.parse('https://www.apicountries.com/countries');
    final request = await HttpClient().getUrl(uri);
    final response = await request.close();
    if (response.statusCode == 200) {
      final respBody = await response.transform(utf8.decoder).join();
      final List jsonData = jsonDecode(respBody);

      return jsonData.map((j) => Country.fromJson(j)).toList();
    } else {
      throw Exception('Failed to load countries: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countries'),
        actions: [
          IconButton(
            icon: Icon(isByRegion ? Icons.public : Icons.sort_by_alpha),
            tooltip: isByRegion ? 'Normal' : 'Benua',
            onPressed: () {
              setState(() {
                isByRegion = !isByRegion;
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Country>>(
        future: countries,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No countries found'));
          }
          final list = List<Country>.from(snapshot.data!);
          if (isByRegion) {
            list.sort((a, b) {
              final regionCmp = a.region.toLowerCase().compareTo(
                b.region.toLowerCase(),
              );
              if (regionCmp != 0) return regionCmp;
              return a.name.toLowerCase().compareTo(b.name.toLowerCase());
            });
          } else {
            list.sort(
              (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
            );
          }
          return ListView.builder(
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
                    HistoryManager.add(country);
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
          );
        },
      ),
    );
  }
}

class Country {
  final String name;
  final String region;
  final String? capital;
  final int population;
  final String? flagsPng;
  final List<dynamic>? languages;
  final List<dynamic>? currencies;
  Country({
    required this.name,
    required this.region,
    required this.population,
    this.capital,
    this.flagsPng,
    this.languages,
    this.currencies,
  });
  factory Country.fromJson(Map<String, dynamic> json) {
    List<dynamic>? langs;
    if (json['languages'] != null) {
      langs = (json['languages'] as List)
          .map((l) => l['name'].toString())
          .toList();
    }
    List<dynamic>? cur;
    if (json['currencies'] != null) {
      cur = (json['currencies'] as List)
          .map((c) => c['name'].toString())
          .toList();
    }
    return Country(
      name: json['name'] ?? 'N/A',
      region: json['region'] ?? 'N/A',
      population: json['population'] ?? 0,
      capital: json['capital'],
      flagsPng: json['flags'] != null ? json['flags']['png'] : null,
      languages: langs,
      currencies: cur,
    );
  }
}
