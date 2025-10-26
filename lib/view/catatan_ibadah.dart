import 'package:flutter/material.dart';
import 'package:ramadhan_app/widgets/bottom_navbar.dart';

class CatatanIbadah extends StatelessWidget {
  const CatatanIbadah({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF202020),
      bottomNavigationBar: const BottomNavBar(currentIndex: 3), // ✅ index aktif
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/taj-mahal-agra-india-3.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xB2202020),
                    Color(0xFF202020),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40), // 🔼 semula 60 → dinaikkan 20px
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
                  const SizedBox(height: 35), // 🔼 semula 50 → sedikit naik
                  _buildMenuButton('Sholat Wajib'),
                  const SizedBox(height: 20), // 🔼 semula 25
                  _buildMenuButton('Ibadah Tambahan'),
                  const SizedBox(height: 20),
                  _buildMenuButton('Tadarus'),
                  const SizedBox(height: 20),
                  _buildMenuButton('Catatan'),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton(String title) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: const Color(0xFFE2BE7F),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 28,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                image: const DecorationImage(
                  image: AssetImage('assets/images/Mosque.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              color: const Color(0x33202020),
            ),
          ),
          Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF202020),
                fontSize: 30,
                fontFamily: 'Aref Ruqaa Ink',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
