import 'package:flutter/material.dart';

class TadarusForm extends StatefulWidget {
  const TadarusForm({super.key});

  @override
  State<TadarusForm> createState() => _TadarusFormState();
}

class _TadarusFormState extends State<TadarusForm> {
  bool isChecked = false; // ✅ Checkbox status
  final TextEditingController juzController = TextEditingController();
  final TextEditingController halamanController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390,
      height: 431,
      decoration: BoxDecoration(
        color: const Color(0xFFE2BE7F),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Stack(
        children: [
          // 🕌 Gambar Masjid bawah
          Positioned(
            bottom: 0,
            child: Container(
              width: 390,
              height: 151,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Mosque.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // 🔸 Header "Tadarus" + Checkbox
          Positioned(
            left: 35,
            top: 65,
            child: Container(
              width: 323,
              height: 55,
              decoration: BoxDecoration(
                color: const Color(0xB2202020),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 1,
                  color: const Color(0xFFE2BE7F),
                ),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  Image.asset(
                    'assets/icons/book-album-svgrepo-com-1.png',
                    width: 26,
                    height: 26,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Tadarus',
                    style: TextStyle(
                      color: Color(0xFFFEFFE8),
                      fontSize: 16,
                      fontFamily: 'Aref Ruqaa Ink',
                    ),
                  ),
                  const Spacer(),

                  // ✅ Checkbox aktif
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isChecked = !isChecked;
                      });
                    },
                    child: Container(
                      width: 22,
                      height: 22,
                      margin: const EdgeInsets.only(right: 15),
                      decoration: BoxDecoration(
                        color: isChecked
                            ? const Color(0xFFE2BE7F)
                            : const Color(0xFF202020),
                        border: Border.all(
                            color: const Color(0xFFE2BE7F), width: 1.5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: isChecked
                          ? const Icon(Icons.check,
                          size: 16, color: Colors.black)
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 🔹 Input JUZ
          Positioned(
            left: 40,
            top: 140,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'JUZ',
                  style: TextStyle(
                    color: Color(0xFF070707),
                    fontSize: 20,
                    fontFamily: 'Aref Ruqaa Ink',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  width: 299,
                  height: 33,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF070707), width: 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    controller: juzController,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF070707),
                      fontFamily: 'Aref Ruqaa Ink',
                      fontSize: 18,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Masukkan Juz...',
                      hintStyle: TextStyle(
                        color: Colors.black45,
                        fontFamily: 'Aref Ruqaa Ink',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 🔹 Input Halaman
          Positioned(
            left: 40,
            top: 230,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Halaman',
                  style: TextStyle(
                    color: Color(0xFF070707),
                    fontSize: 20,
                    fontFamily: 'Aref Ruqaa Ink',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  width: 299,
                  height: 33,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF070707), width: 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    controller: halamanController,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF070707),
                      fontFamily: 'Aref Ruqaa Ink',
                      fontSize: 18,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Masukkan Halaman...',
                      hintStyle: TextStyle(
                        color: Colors.black45,
                        fontFamily: 'Aref Ruqaa Ink',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 🔘 Tombol Simpan
          Positioned(
            right: 40,
            bottom: 25,
            child: GestureDetector(
              onTap: () {
                final juz = juzController.text;
                final halaman = halamanController.text;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Disimpan: Juz $juz, Halaman $halaman, Selesai: $isChecked'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              child: Container(
                width: 81,
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0x99202020),
                  borderRadius: BorderRadius.circular(66),
                ),
                child: const Center(
                  child: Text(
                    'Simpan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'Aref Ruqaa Ink',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
