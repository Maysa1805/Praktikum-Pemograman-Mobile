import 'package:flutter/material.dart';
import 'package:ramadhan_app/view/catatan_ibadah.dart';

class CatatanListPage extends StatefulWidget {
  const CatatanListPage({super.key});

  @override
  State<CatatanListPage> createState() => _CatatanListPageState();
}

class _CatatanListPageState extends State<CatatanListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF202020),
      appBar: AppBar(
        backgroundColor: const Color(0xFF202020),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFFE2BE7F)),
        title: const Text(
          "Daftar Catatan",
          style: TextStyle(
            color: Color(0xFFE2BE7F),
            fontFamily: 'Aref Ruqaa',
            fontSize: 28,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: catatanList.length,
          itemBuilder: (context, index) {
            final catatan = catatanList[index];

            return Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              padding:
              const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
              decoration: BoxDecoration(
                color: const Color(0xFFE2BE7F),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  // JUDUL CATATAN
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // tampilan popup isi catatan
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            backgroundColor: const Color(0xFFE2BE7F),
                            title: Text(
                              catatan['judul'] ?? '',
                              style: const TextStyle(
                                fontFamily: 'Aref Ruqaa Ink',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: Text(
                              catatan['isi'] ?? '',
                              style: const TextStyle(
                                  fontFamily: 'Aref Ruqaa Ink'),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text(
                                  "Tutup",
                                  style: TextStyle(
                                      fontFamily: 'Aref Ruqaa Ink'),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Text(
                        catatan['judul'] ?? '',
                        style: const TextStyle(
                          color: Color(0xFF202020),
                          fontSize: 24,
                          fontFamily: 'Aref Ruqaa Ink',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  // ✏️ EDIT
                  IconButton(
                    icon: const Icon(Icons.edit, color: Color(0xFF202020)),
                    onPressed: () {
                      _showEditDialog(index);
                    },
                  ),

                  // 🗑 HAPUS
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _showDeleteDialog(index);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // =============================
  //      FUNGSI DELETE CATATAN
  // =============================
  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFFE2BE7F),
        title: const Text(
          "Hapus Catatan?",
          style: TextStyle(fontFamily: 'Aref Ruqaa Ink'),
        ),
        content: const Text(
          "Apakah kamu yakin ingin menghapus catatan ini?",
          style: TextStyle(fontFamily: 'Aref Ruqaa Ink'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                catatanList.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: const Text(
              "Hapus",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  // =============================
  //      FUNGSI EDIT CATATAN
  // =============================
  void _showEditDialog(int index) {
    final judulController =
    TextEditingController(text: catatanList[index]['judul']);
    final isiController =
    TextEditingController(text: catatanList[index]['isi']);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFFE2BE7F),
        title: const Text(
          "Edit Catatan",
          style: TextStyle(fontFamily: 'Aref Ruqaa Ink'),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: judulController,
              decoration: const InputDecoration(
                hintText: "Judul",
                hintStyle: TextStyle(fontFamily: 'Aref Ruqaa Ink'),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: isiController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: "Isi catatan",
                hintStyle: TextStyle(fontFamily: 'Aref Ruqaa Ink'),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                catatanList[index]['judul'] = judulController.text;
                catatanList[index]['isi'] = isiController.text;
              });

              Navigator.pop(context);
            },
            child: const Text("Simpan"),
          ),
        ],
      ),
    );
  }
}
