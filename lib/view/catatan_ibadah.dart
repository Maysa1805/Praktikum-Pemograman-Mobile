import 'package:flutter/material.dart';
import 'package:ramadhan_app/widgets/bottom_navbar.dart';
import 'package:ramadhan_app/pages/sholat_history_page.dart';
import 'package:ramadhan_app/pages/ibadah_tambahan_history.dart';
import 'package:ramadhan_app/pages/tadarus_history_page.dart';
import 'package:ramadhan_app/pages/catatan_list_page.dart'; // ✅ halaman baru
import 'package:ramadhan_app/viewmodel/catatan.dart';

// List Tadarus
List<Map<String, dynamic>> tadarusList = [];

// List Catatan
List<Map<String, String>> catatanList = [];

class CatatanIbadah extends StatelessWidget {
  const CatatanIbadah({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF202020),
      bottomNavigationBar: const BottomNavBar(currentIndex: 3),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Text(
                'Catatan',
                style: TextStyle(
                  color: Color(0xFFE2BE7F),
                  fontSize: 55,
                  fontFamily: 'Aref Ruqaa',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Ibadah',
                style: TextStyle(
                  color: Color(0xFFC0A37C),
                  fontSize: 50,
                  fontFamily: 'Aref Ruqaa',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 35),

              _buildMenuButton('Sholat Wajib', () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const SholatHistoryPage()));
              }),
              const SizedBox(height: 20),

              _buildMenuButton('Ibadah Tambahan', () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const IbadahTambahanHistoryPage()));
              }),
              const SizedBox(height: 20),

              _buildMenuButton('Tadarus', () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const TadarusHistoryPage()));
              }),
              const SizedBox(height: 20),

              // ⭐ TOMBOL CATATAN BARU
              _buildMenuButton('Catatan', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CatatanListPage()),
                );
              }),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          color: const Color(0xFFE2BE7F),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Color(0xFF202020),
              fontSize: 30,
              fontFamily: 'Aref Ruqaa Ink',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
