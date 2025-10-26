import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:ramadhan_app/widgets/bottom_navbar.dart';
import 'package:ramadhan_app/widgets/time_card.dart';

class TimePage extends StatefulWidget {
  const TimePage({super.key});

  @override
  State<TimePage> createState() => _TimePageState();
}

class _TimePageState extends State<TimePage> {
  Map<String, dynamic>? data;

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    final String response =
    await rootBundle.loadString('assets/data/pray_time.json');
    final jsonData = json.decode(response);
    setState(() {
      data = jsonData;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return const Scaffold(
        backgroundColor: Color(0xFF202020),
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFFE2BE7F)),
        ),
      );
    }

    final times = data!['times'] as List<dynamic>;

    return Scaffold(
      backgroundColor: const Color(0xFF202020),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
      body: Stack(
        children: [
          // 🔹 Background
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image:
                const AssetImage('assets/images/taj-mahal-agra-india-4.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.7),
                  BlendMode.darken,
                ),
              ),
            ),
          ),

          // 🔹 Card utama waktu sholat
          Positioned(
            left: 20,
            top: 310,
            child: Container(
              width: 390,
              height: 300,
              decoration: BoxDecoration(
                color: const Color(0xFF846B3F),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Stack(
                children: [
                  // Header tanggal
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 390,
                      height: 90,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 26,
                            top: 14,
                            child: Text(
                              data!['date'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Aref Ruqaa Ink',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 140,
                            top: 4,
                            child: Text(
                              'Pray Time',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 20,
                                fontFamily: 'Janna LT',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 154,
                            top: 38,
                            child: Text(
                              data!['day'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xE5202020),
                                fontSize: 20,
                                fontFamily: 'Janna LT',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 26,
                            top: 14,
                            child: Text(
                              data!['hijri'],
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Aref Ruqaa Ink',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // 🔹 Scroll waktu sholat dari JSON
                  Positioned(
                    top: 100,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 180,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE2BE7F),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 15),
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              padding:
                              const EdgeInsets.symmetric(horizontal: 25),
                              child: Row(
                                children: times.map((item) {
                                  return Padding(
                                    padding:
                                    const EdgeInsets.only(right: 16),
                                    child: TimeCard(
                                      name: item['name'],
                                      time: item['time'],
                                      meridiem: item['meridiem'],
                                      highlight: item['highlight'] ?? false,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Next Pray',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.7),
                                    fontSize: 16,
                                    fontFamily: 'Janna LT',
                                  ),
                                ),
                                TextSpan(
                                  text: ' - ${data!['next_pray']}',
                                  style: const TextStyle(
                                    color: Color(0xFF202020),
                                    fontSize: 16,
                                    fontFamily: 'Janna LT',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 🔹 Objek masjid (turun sedikit)
          Positioned(
            left: 28,
            top: 110, // ⬇️ dari 85 → 110
            child: Image.asset(
              'assets/icons/OBJECTS.png',
              width: 83,
              height: 76,
            ),
          ),

          // 🔹 Ramadhan Kareem (turun sedikit juga)
          const Positioned(
            left: 129,
            top: 95, // ⬇️ dari 70 → 95
            child: Text(
              'Ramadhan',
              style: TextStyle(
                color: Color(0xFFE2BE7F),
                fontSize: 50,
                fontFamily: 'Aref Ruqaa',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Positioned(
            left: 172,
            top: 142, // ⬇️ dari 117 → 142
            child: Text(
              'Kareem',
              style: TextStyle(
                color: Color(0xFFC0A37C),
                fontSize: 50,
                fontFamily: 'Aref Ruqaa',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // 🔹 Arrow clickable (lebih kecil & lebih ke bawah)
          Positioned(
            left: 20,
            top: 55, // ⬇️ lebih rendah
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.pop(context);
              },
              child: SizedBox(
                width: 40,
                height: 40,
                child: Image.asset(
                  'assets/icons/Arrow-1.png',
                  width: 25,
                  height: 25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
