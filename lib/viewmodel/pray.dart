import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:ramadhan_app/widgets/pray_card.dart';
import 'package:ramadhan_app/pages/sholat_wajib_page.dart';

// 📌 Global class untuk menyimpan record sholat
class SholatRecord {
  final DateTime date;
  final List<Map<String, dynamic>> sholatData;

  SholatRecord({required this.date, required this.sholatData});
}

// 📌 Global list untuk menyimpan semua record sholat
List<SholatRecord> sholatRecords = [];

class PrayPage extends StatefulWidget {
  const PrayPage({super.key});

  @override
  State<PrayPage> createState() => _PrayPageState();
}

class _PrayPageState extends State<PrayPage> {
  List prayers = [];
  List<bool> checked = [];

  Future<void> loadJsonData() async {
    final String response =
    await rootBundle.loadString('assets/data/pray_data.json');
    final data = await json.decode(response);

    setState(() {
      prayers = data;
      checked = List.generate(prayers.length, (index) => false);
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
          // 📌 Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/taj-mahal-agra-india-1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 📌 Dark Gradient Overlay
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xB2202020), Color(0xFF202020)],
              ),
            ),
          ),

          // 📌 Main Content
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔙 Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Image.asset(
                          'assets/icons/Arrow-1.png',
                          width: 25,
                        ),
                      ),
                      const SizedBox(height: 8),

                      Row(
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

                // 📜 List Shalat
                Expanded(
                  child: prayers.isEmpty
                      ? const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFFE2BE7F),
                    ),
                  )
                      : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    itemCount: prayers.length,
                    itemBuilder: (context, index) {
                      final p = prayers[index];

                      return PrayCard(
                        number: p['number'],
                        name: p['name'],
                        arabic: p['arabic'],

                        // 📌 Callback dari checkbox PrayCard
                        isChecked: checked[index],
                        onChanged: (value) {
                          setState(() {
                            checked[index] = value;
                          });
                        },
                      );
                    },
                  ),
                ),

                // 📌 Submit Button
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 40, bottom: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        List selected = [];

                        for (int i = 0; i < prayers.length; i++) {
                          if (checked[i]) {
                            selected.add(prayers[i]);
                          }
                        }

                        if (selected.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Checklist dulu salah satu shalat"),
                            ),
                          );
                          return;
                        }

                        // 📌 Simpan record sesuai tanggal submit
                        sholatRecords.add(SholatRecord(
                          date: DateTime.now(),
                          sholatData: selected.cast<Map<String, dynamic>>(),
                        ));

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SholatWajibPage(
                              sholatData: selected.cast<Map<String, dynamic>>(),
                              date: DateTime.now(),
                            ),
                          ),
                        );
                      },
                      child: const Text("Submit"),
                    ),
                  ),
                ),

                // 🕌 Footer
                Container(
                  width: double.infinity,
                  height: 120,
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
