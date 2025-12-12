import 'package:flutter/material.dart';
import 'package:ramadhan_app/view/catatan_ibadah.dart';

class TadarusHistoryPage extends StatelessWidget {
  const TadarusHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF202020),
      appBar: AppBar(
        backgroundColor: const Color(0xFF202020),
        title: const Text('Tadarus History'),
      ),
      body: tadarusList.isEmpty
          ? const Center(
        child: Text(
          'Belum ada catatan Tadarus',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: tadarusList.length,
        itemBuilder: (context, index) {
          final item = tadarusList[index];
          return ListTile(
            title:
            Text('Juz ${item['juz']}, Halaman ${item['halaman']}',
                style: const TextStyle(color: Colors.white)),
            subtitle:
            Text(item['tanggal'], style: const TextStyle(color: Colors.grey)),
            trailing: item['selesai']
                ? const Icon(Icons.check, color: Colors.green)
                : null,
          );
        },
      ),
    );
  }
}
