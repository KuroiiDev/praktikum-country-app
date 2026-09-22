import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final VoidCallback? onHomeTap;
  const ProfilePage({super.key, this.onHomeTap});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final List<Map<String, String>> teamMembers = [
    {'Nama': 'Maitsam Kadzim', 'NIM': '21120124140161'},
    {'Nama': 'Gotara Adi Prasetiyo', 'NIM': '21120124140157'},
    {'Nama': 'Faiz Alif Rahmawan', 'NIM': '2112012413063'},
    {'Nama': 'Rafi Nurulhuda', 'NIM': '2112012413053'},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: const Color.fromARGB(255, 13, 105, 225),
        actions: [
          IconButton(icon: const Icon(Icons.home), onPressed: widget.onHomeTap),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: FractionallySizedBox(
              alignment: Alignment.topCenter,
              heightFactor: 0.5,
              child: Container(
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    image: AssetImage('lib/team.jpg'),
                  ),
                  color: const Color.fromARGB(
                    255,
                    255,
                    252,
                    252,
                  ).withValues(alpha: 128),
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        'https://maitsam-kadzim.my.id/images/profile.png',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                for (var member in teamMembers)
                  Column(
                    children: [
                      Text(
                        member['Nama'] ?? 'No Name',
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        member['NIM'] ?? 'No NIM',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
