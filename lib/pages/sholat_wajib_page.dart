import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SholatWajibPage extends StatelessWidget {
  final List<Map<String, dynamic>> sholatData;
  final DateTime date;

  const SholatWajibPage({
    super.key,
    required this.sholatData,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd MMMM yyyy').format(date);

    return Scaffold(
      backgroundColor: const Color(0xFF202020),
      appBar: AppBar(
        backgroundColor: const Color(0xFF202020),
        title: Text(formattedDate),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: sholatData.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFE2BE7F),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              sholatData[index]['name'],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF202020),
              ),
            ),
          );
        },
      ),
    );
  }
}
