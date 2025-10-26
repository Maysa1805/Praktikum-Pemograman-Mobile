import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:ramadhan_app/widgets/daily_bottom.dart';
import 'package:ramadhan_app/viewmodel/pray.dart';
import 'package:ramadhan_app/viewmodel/ibadah_tambahan.dart';
import 'package:ramadhan_app/viewmodel/tadarus.dart';
import 'package:ramadhan_app/viewmodel/time.dart';
import 'package:ramadhan_app/viewmodel/catatan.dart'; // ✅ Tambahkan import ini

class DailyActivitie extends StatefulWidget {
  const DailyActivitie({super.key});

  @override
  State<DailyActivitie> createState() => _DailyActivitieState();
}

class _DailyActivitieState extends State<DailyActivitie> {
  List activities = [];

  Future<void> loadActivities() async {
    try {
      final String response =
      await rootBundle.loadString('assets/data/activity_data.json');
      final List<dynamic> data = json.decode(response);
      setState(() {
        activities = data;
      });
    } catch (e) {
      debugPrint("Gagal memuat data aktivitas: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    loadActivities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF202020),
      bottomNavigationBar: const DailyBottom(currentIndex: 1), // ✅ ubah di sini
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Daily Activitie',
                    style: TextStyle(
                      color: Color(0xFFE2BE7F),
                      fontSize: 22,
                      fontFamily: 'Aref Ruqaa Ink',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset('assets/images/corner_left.png', width: 80),
                const Text(
                  'رمضان',
                  style: TextStyle(
                    color: Color(0xFFE2BE7F),
                    fontSize: 30,
                    fontFamily: 'Reem Kufi',
                  ),
                ),
                Image.asset('assets/images/corner_right.png', width: 80),
              ],
            ),
            const SizedBox(height: 30),

            Expanded(
              child: activities.isEmpty
                  ? const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFE2BE7F),
                ),
              )
                  : ListView.builder(
                itemCount: activities.length,
                itemBuilder: (context, index) {
                  final item = activities[index];
                  final String title = item['title'] ?? 'Tanpa Judul';
                  return _menuButton(context, title);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuButton(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          switch (title) {
            case "Sholat Wajib":
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PrayPage()),
              );
              break;

            case "Ibadah Tambahan":
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const IbadahTambahan()),
              );
              break;

            case "Tadarus":
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TadarusPage()),
              );
              break;

            case "Waktu Sholat":
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TimePage()),
              );
              break;

            case "Catatan": // ✅ Tambahan untuk halaman catatan
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CatatanPage()),
              );
              break;

            default:
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$title belum tersedia')),
              );
          }
        },
        child: Container(
          height: 65,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: const Color(0xFFE2BE7F)),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                color: Color(0xFFE2BE7F),
                fontSize: 20,
                fontFamily: 'Aref Ruqaa Ink',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
