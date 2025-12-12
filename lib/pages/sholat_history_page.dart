import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ramadhan_app/viewmodel/pray.dart';
import 'package:ramadhan_app/pages/sholat_wajib_page.dart';

class SholatHistoryPage extends StatelessWidget {
  const SholatHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF202020),
      appBar: AppBar(
        title: const Text('History Sholat'),
        backgroundColor: const Color(0xFF202020),
      ),
      body: sholatRecords.isEmpty
          ? const Center(
        child: Text(
          'Belum ada history sholat',
          style: TextStyle(color: Colors.white),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: sholatRecords.length,
        itemBuilder: (context, index) {
          final record = sholatRecords[index];
          final date =
          DateFormat('dd MMMM yyyy').format(record.date);

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SholatWajibPage(
                    sholatData: record.sholatData,
                    date: record.date,
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 15),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFE2BE7F),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                date,
                style: const TextStyle(
                  color: Color(0xFF202020),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
