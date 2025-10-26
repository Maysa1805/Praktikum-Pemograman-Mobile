import 'package:flutter/material.dart';
import 'package:ramadhan_app/view/daily_activitie.dart';
import 'package:ramadhan_app/widgets/daily_bottom.dart';
import 'package:ramadhan_app/widgets/tadarus_form.dart'; // ✅ Panggil form dari folder widgets

class TadarusPage extends StatelessWidget {
  const TadarusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF202020),
      bottomNavigationBar: const DailyBottom(),
      body: Stack(
        children: [
          // 🌄 Background + gradasi
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/taj-mahal-agra-india-2.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xB2202020), Color(0xFF202020)],
                ),
              ),
            ),
          ),

          // 🌙 Isi halaman
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),

                // 🔙 Arrow + Judul "Tadarus"
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DailyActivitie()),
                          );
                        },
                        child: Image.asset(
                          'assets/icons/Arrow-1.png',
                          width: 35,
                          height: 35,
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        'Tadarus',
                        style: TextStyle(
                          color: Color(0xFFE2BE7F),
                          fontSize: 28,
                          fontFamily: 'Aref Ruqaa Ink',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(flex: 2),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // 🔸 Tulisan arab تدارس
                const Text(
                  'تَدَارُس',
                  style: TextStyle(
                    color: Color(0xFFE2BE7F),
                    fontSize: 45,
                    fontFamily: 'Reem Kufi',
                  ),
                ),

                const SizedBox(height: 40),

                // 🕌 Form Tadarus (dipisah ke file widgets)
                const TadarusForm(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
