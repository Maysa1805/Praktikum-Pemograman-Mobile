import 'package:flutter/material.dart';
import 'package:ramadhan_app/view/daily_activitie.dart';
import 'package:ramadhan_app/view/catatan_ibadah.dart'; // akses catatanList

class CatatanPage extends StatefulWidget {
  const CatatanPage({super.key});

  @override
  State<CatatanPage> createState() => _CatatanPageState();
}

class _CatatanPageState extends State<CatatanPage> {
  final TextEditingController judulController = TextEditingController();
  final TextEditingController isiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF202020),
      body: Stack(
        children: [
          Positioned(
            left: 20,
            top: 40,
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DailyActivitie(),
                  ),
                );
              },
              child: Image.asset(
                'assets/icons/Arrow-1.png',
                width: 28,
                color: const Color(0xFFE2BE7F),
              ),
            ),
          ),

          Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Notes',
                style: TextStyle(
                  color: const Color(0xFFE2BE7F),
                  fontSize: 50,
                  fontFamily: 'Aref Ruqaa',
                ),
              ),
            ),
          ),

          Positioned(
            top: 200,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFE2BE7F),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: judulController,
                    decoration: InputDecoration(
                      hintText: 'Judul Catatan',
                      filled: true,
                      fillColor: const Color(0xB2202020),
                      hintStyle: const TextStyle(
                        color: Colors.white70,
                        fontFamily: 'Aref Ruqaa Ink',
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Color(0xFFE2BE7F), width: 1),
                      ),
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Aref Ruqaa Ink',
                    ),
                  ),

                  const SizedBox(height: 25),

                  TextField(
                    controller: isiController,
                    maxLines: 10,
                    decoration: InputDecoration(
                      hintText: 'Tulis catatanmu di sini...',
                      filled: true,
                      fillColor: const Color(0x6D202020),
                      hintStyle: const TextStyle(
                        color: Colors.white70,
                        fontFamily: 'Aref Ruqaa Ink',
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Color(0xFFE2BE7F), width: 1),
                      ),
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Aref Ruqaa Ink',
                    ),
                  ),

                  const SizedBox(height: 20),

                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0x99202020),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(66),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 12),
                      ),
                      onPressed: () {
                        final judul = judulController.text;
                        final isi = isiController.text;

                        if (judul.isEmpty || isi.isEmpty) return;

                        // SIMPAN CATATAN
                        catatanList.add({
                          'judul': judul,
                          'isi': isi,
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("✅ Catatan disimpan!")),
                        );

                        setState(() {
                          judulController.clear();
                          isiController.clear();
                        });
                      },
                      child: const Text(
                        "Simpan",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'Aref Ruqaa Ink',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/Mosque.png',
              fit: BoxFit.cover,
              height: 120,
            ),
          ),
        ],
      ),
    );
  }
}
