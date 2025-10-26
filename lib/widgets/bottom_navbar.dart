import 'package:flutter/material.dart';
import 'package:ramadhan_app/view/home_screen.dart';
import 'package:ramadhan_app/view/daily_activitie.dart';
import 'package:ramadhan_app/view/catatan_ibadah.dart'; // halaman Catatan Ibadah

class BottomNavBar extends StatefulWidget {
  final int currentIndex; //  Tambahan agar tahu posisi halaman aktif
  const BottomNavBar({super.key, this.currentIndex = 0});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.currentIndex;
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return; // biar tidak reload halaman yang sama
    setState(() => _selectedIndex = index);

    // 🔹 Navigasi antar halaman
    switch (index) {
      case 0: // Home
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        break;

      case 1: // Daily Activity
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DailyActivitie()),
        );
        break;

      case 2: // Radio (belum tersedia)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Halaman Radio belum tersedia')),
        );
        break;

      case 3: // ✅ Catatan Ibadah
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const CatatanIbadah()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xFFF2C17D),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem('assets/icons/vector_1.png', 0),
          _buildNavItem('assets/icons/book-album-svgrepo-com-1.png', 1),
          _buildNavItem('assets/icons/radio-svgrepo-com-1.png', 2),
          _buildNavItem('assets/icons/vector.png', 3), // tetap sama
        ],
      ),
    );
  }

  Widget _buildNavItem(String asset, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(
          _selectedIndex == index ? Colors.black : Colors.black54,
          BlendMode.srcIn,
        ),
        child: Image.asset(asset, height: 35),
      ),
    );
  }
}
