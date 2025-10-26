import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:ramadhan_app/widgets/pray_card.dart';

class PrayPage extends StatefulWidget {
  const PrayPage({super.key});

  @override
  State<PrayPage> createState() => _PrayPageState();
}

class _PrayPageState extends State<PrayPage> {
  List prayers = [];

  // ✅ Fungsi untuk membaca file JSON dari assets/data/
  Future<void> loadJsonData() async {
    final String response =
    await rootBundle.loadString('assets/data/pray_data.json');
    final data = await json.decode(response);
    setState(() {
      prayers = data;
    });
  }

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF202020),
      body: Stack(
        children: [
          // 🌄 Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/taj-mahal-agra-india-1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 🌙 Overlay gradient gelap
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xB2202020), Color(0xFF202020)],
              ),
            ),
          ),

          // 🕌 Konten utama
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔙 Header (Arrow di atas, Ramadhan Kareem di bawahnya)
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Arrow di baris paling atas
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Image.asset(
                          'assets/icons/Arrow-1.png',
                          width: 25,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Logo + Text Ramadhan Kareem
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/OBJECTS.png',
                            width: 67,
                          ),
                          const SizedBox(width: 10),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ramadhan',
                                style: TextStyle(
                                  color: Color(0xFFE2BE7F),
                                  fontSize: 35,
                                  fontFamily: 'Aref Ruqaa Bold',
                                ),
                              ),
                              Text(
                                'Kareem',
                                style: TextStyle(
                                  color: Color(0xFFC0A37C),
                                  fontSize: 32,
                                  fontFamily: 'Aref Ruqaa Bold',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // 📜 List Shalat (baca dari JSON)
                Expanded(
                  child: prayers.isEmpty
                      ? const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFFE2BE7F),
                    ),
                  )
                      : ListView.builder(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 40),
                    itemCount: prayers.length,
                    itemBuilder: (context, index) {
                      final p = prayers[index];
                      return PrayCard(
                        number: p['number'],
                        name: p['name'],
                        arabic: p['arabic'],
                      );
                    },
                  ),
                ),

                // 🕌 Footer (Full kanan kiri)
                Container(
                  width: double.infinity,
                  height: 120,
                  alignment: Alignment.bottomCenter,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/Mosque.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
