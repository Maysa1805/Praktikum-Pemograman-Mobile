import 'package:flutter/material.dart';

class IbadahTambahanPage extends StatelessWidget {
  final List<Map<String, dynamic>> ibadahData;
  final String tanggal;

  const IbadahTambahanPage({
    super.key,
    required this.ibadahData,
    required this.tanggal,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF202020),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Ibadah Tambahan Hari Ini",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔥 Tampilkan tanggal realtime
            Text(
              "Tanggal: $tanggal",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              "Daftar Ibadah Tambahan:",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: ibadahData.isEmpty
                  ? const Center(
                child: Text(
                  "Belum ada ibadah yang dicentang",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              )
                  : ListView.builder(
                itemCount: ibadahData.length,
                itemBuilder: (context, index) {
                  final item = ibadahData[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      item["name"],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
