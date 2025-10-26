import 'package:flutter/material.dart';
import 'package:ramadhan_app/widgets/bottom_navbar.dart';

class DailyBottom extends StatelessWidget {
  final int currentIndex; // ✅ Tambahan agar bisa menentukan posisi aktif
  const DailyBottom({super.key, this.currentIndex = 0});

  @override
  Widget build(BuildContext context) {
    return BottomNavBar(currentIndex: currentIndex);
  }
}
