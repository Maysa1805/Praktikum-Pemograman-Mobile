import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ramadhan_app/data/ibadah_tambahan_store.dart';

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

  void _submitData() {
    List<Map<String, dynamic>> ibadahList = [
      {"name": "Puasa", "value": puasa},
      {"name": "Terawih", "value": terawih},
      {"name": "Dzikir", "value": dzikir},
      {"name": "Sholat Tahajud", "value": tahajud},
      {"name": "Sholat Dhuha", "value": dhuha},
      {"name": "Sedekah", "value": sedekah},
    ];

    final doneIbadah =
    ibadahList.where((item) => item["value"] == true).toList();

    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    // ✅ SIMPAN DATA SESUAI TANGGAL
    IbadahTambahanStore.save(today, doneIbadah);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF202020),
      body: SafeArea(
        child: Stack(
          children: [
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
            const Positioned(
              top: 70,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'Ibadah Tambahan',
                  style: TextStyle(
                    color: Color(0xFFE2BE7F),
                    fontSize: 28,
                    fontFamily: 'Aref Ruqaa Ink',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              top: 155,
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 100),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
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
                    const SizedBox(height: 70),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 130,
              right: 40,
              child: TextButton(
                onPressed: _submitData,
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFFE2BE7F),
                  foregroundColor: const Color(0xFF202020),
                  padding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 26),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Simpan",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Aref Ruqaa',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xFFE2BE7F),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color:
                  value ? Colors.grey[600] : const Color(0xFF202020),
                  fontSize: 21,
                  fontFamily: 'Aref Ruqaa',
                  decoration:
                  value ? TextDecoration.lineThrough : null,
                ),
              ),
              Checkbox(
                value: value,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
