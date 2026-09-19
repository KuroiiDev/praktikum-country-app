import 'package:flutter/material.dart';
import 'widget/navigation.dart';
void main() {
  runApp(const CountryApp());
}
class CountryApp extends StatelessWidget {
  const CountryApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ApiCountries Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,

      ),
      home: const NavigationPage(),
    );
  }
}