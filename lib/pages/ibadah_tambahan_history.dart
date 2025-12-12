import 'package:flutter/material.dart';
import 'package:ramadhan_app/data/ibadah_tambahan_store.dart';

class IbadahTambahanHistoryPage extends StatelessWidget {
  const IbadahTambahanHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final data = IbadahTambahanStore.getAll();

    return Scaffold(
      backgroundColor: const Color(0xFF202020),
      appBar: AppBar(
        backgroundColor: const Color(0xFF202020),
        title: const Text(
          'Ibadah Tambahan',
          style: TextStyle(
            color: Color(0xFFE2BE7F),
            fontFamily: 'Aref Ruqaa',
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFFE2BE7F)),
      ),
      body: data.isEmpty
          ? const Center(
        child: Text(
          'Belum ada data',
          style: TextStyle(color: Colors.white70),
        ),
      )
          : ListView(
        padding: const EdgeInsets.all(16),
        children: data.entries.map((entry) {
          return Container(
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
              color: const Color(0xFFE2BE7F),
              borderRadius: BorderRadius.circular(14),
            ),
            child: ExpansionTile(
              title: Text(
                entry.key,
                style: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'Aref Ruqaa',
                  color: Color(0xFF202020),
                ),
              ),
              children: entry.value.map((ibadah) {
                return ListTile(
                  title: Text(
                    ibadah['name'],
                    style: const TextStyle(
                      fontFamily: 'Aref Ruqaa',
                      color: Color(0xFF202020),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        }).toList(),
      ),
    );
  }
}
