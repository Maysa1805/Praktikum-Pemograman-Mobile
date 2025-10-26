import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ramadhan_app/widgets/bottom_navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? hadistData;

  @override
  void initState() {
    super.initState();
    loadHadistData();
  }

  Future<void> loadHadistData() async {
    final String response =
    await rootBundle.loadString('assets/data/hadist_data.json');
    final data = json.decode(response);
    setState(() {
      hadistData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (hadistData == null) {
      return const Scaffold(
        backgroundColor: Color(0xFF1E1E1E),
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFFF2C17D)),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/taj-mahal-agra-india-1.png',
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.6),
              colorBlendMode: BlendMode.darken,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/OBJECTS.png',
                        height: 70,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Ramadhan',
                            style: TextStyle(
                              fontFamily: 'ArefRuqaaInk',
                              color: Color(0xFFF2C17D),
                              fontSize: 36,
                            ),
                          ),
                          Text(
                            'Kareem',
                            style: TextStyle(
                              fontFamily: 'ArefRuqaaInk',
                              color: Color(0xFFF2C17D),
                              fontSize: 36,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2C17D),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Text(
                          hadistData!['hari_arab'] ?? '',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Amiri',
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          hadistData!['hari_latin'] ?? '',
                          style: const TextStyle(
                            fontFamily: 'ArefRuqaa',
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          hadistData!['sisa_hari'] ?? '',
                          style: const TextStyle(
                            fontFamily: 'ReemKufi',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Divider(color: Colors.white70, thickness: 1),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      border: Border.all(color: const Color(0xFFF2C17D)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'قال رسول الله ﷺ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Amiri',
                            fontSize: 22,
                            color: Color(0xFFF2C17D),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          hadistData!['hadist_arab'] ?? '',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Amiri',
                            fontSize: 20,
                            color: Color(0xFFF2C17D),
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Artinya:\n${hadistData!['arti'] ?? ''}',
                      style: const TextStyle(
                        fontFamily: 'ReemKufi',
                        fontSize: 18,
                        color: Colors.white,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0), // ✅ ubah di sini
    );
  }
}
