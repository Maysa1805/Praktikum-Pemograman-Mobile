import 'package:flutter/material.dart';
import 'view/home_screen.dart';
import 'view/daily_activitie.dart';
import 'viewmodel/ibadah_tambahan.dart'; // ⬅️ tambahkan ini

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ramadhan Tracker',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF202020),
      ),
      home: const HomeScreen(),
      routes: {
        '/daily_activie': (context) => const DailyActivitie(),
        '/ibadah_tambahan': (context) => const IbadahTambahan(), // ⬅️ tambahkan route baru
      },
    );
  }
}
