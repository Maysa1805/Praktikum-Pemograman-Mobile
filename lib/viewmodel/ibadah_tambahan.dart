import 'package:flutter/material.dart';

class IbadahTambahan extends StatefulWidget {
  const IbadahTambahan({super.key});

  @override
  State<IbadahTambahan> createState() => _IbadahTambahanState();
}

class _IbadahTambahanState extends State<IbadahTambahan> {
  bool puasa = false;
  bool terawih = false;
  bool dzikir = false;
  bool tahajud = false;
  bool dhuha = false;
  bool sedekah = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF202020),
      body: SafeArea(
        child: Stack(
          children: [
            // 🕌 Gambar bawah
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/images/Mosque.png',
                fit: BoxFit.cover,
                height: 112,
              ),
            ),

            // 🔙 Tombol kembali
            Positioned(
              top: 20,
              left: 16,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Image.asset(
                  'assets/icons/Arrow-1.png',
                  width: 25,
                ),
              ),
            ),

            // 🌙 Dekorasi pojok
            Positioned(
              top: 55,
              left: 16,
              child: Image.asset('assets/images/corner_left.png', width: 90),
            ),
            Positioned(
              top: 55,
              right: 16,
              child: Image.asset('assets/images/corner_right.png', width: 90),
            ),

            // 🔹 Judul (dinaikkan sedikit)
            const Positioned(
              top: 70, // sebelumnya 100 → dinaikkan sedikit
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'Ibadah Tambahan',
                  style: TextStyle(
                    color: Color(0xFFE2BE7F),
                    fontSize: 28, // sedikit lebih kecil dari 30
                    fontFamily: 'Aref Ruqaa Ink',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // 🔹 Daftar ibadah tambahan (lebih kecil & dinaikkan)
            Positioned.fill(
              top: 155, // sebelumnya 175 → dinaikkan agar lebih ke atas
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30), // dikurangi dari 40

                    _IbadahItem(
                      title: 'Puasa',
                      value: puasa,
                      onChanged: (v) => setState(() => puasa = v!),
                    ),
                    const SizedBox(height: 14),

                    _IbadahItem(
                      title: 'Terawih',
                      value: terawih,
                      onChanged: (v) => setState(() => terawih = v!),
                    ),
                    const SizedBox(height: 14),

                    _IbadahItem(
                      title: 'Dzikir',
                      value: dzikir,
                      onChanged: (v) => setState(() => dzikir = v!),
                    ),
                    const SizedBox(height: 14),

                    _IbadahItem(
                      title: 'Sholat Tahajud',
                      value: tahajud,
                      onChanged: (v) => setState(() => tahajud = v!),
                    ),
                    const SizedBox(height: 14),

                    _IbadahItem(
                      title: 'Sholat Dhuha',
                      value: dhuha,
                      onChanged: (v) => setState(() => dhuha = v!),
                    ),
                    const SizedBox(height: 14),

                    _IbadahItem(
                      title: 'Sedekah',
                      value: sedekah,
                      onChanged: (v) => setState(() => sedekah = v!),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 🔸 Widget tombol ibadah
class _IbadahItem extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const _IbadahItem({
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40), // sedikit lebih rapat
      child: Container(
        height: 50, // sebelumnya 60 → sedikit lebih kecil
        decoration: BoxDecoration(
          color: const Color(0xFFE2BE7F),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1, color: const Color(0xFFE2BE7F)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: value ? Colors.grey[600] : const Color(0xFF202020),
                  fontSize: 21, // sebelumnya 23 → lebih kecil sedikit
                  fontFamily: 'Aref Ruqaa',
                  decoration:
                  value ? TextDecoration.lineThrough : TextDecoration.none,
                  decorationColor: Colors.grey[600],
                  decorationThickness: 2,
                ),
              ),
              SizedBox(
                width: 20,
                height: 20,
                child: Checkbox(
                  value: value,
                  onChanged: onChanged,
                  side: const BorderSide(color: Color(0xFF070707), width: 2),
                  checkColor: const Color(0xFFE2BE7F),
                  activeColor: const Color(0xFF070707),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
