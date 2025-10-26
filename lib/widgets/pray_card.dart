import 'package:flutter/material.dart';

class PrayCard extends StatefulWidget {
  final String number;
  final String name;
  final String arabic;

  const PrayCard({
    super.key,
    required this.number,
    required this.name,
    required this.arabic,
  });

  @override
  State<PrayCard> createState() => _PrayCardState();
}

class _PrayCardState extends State<PrayCard> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center, // ✅ biar konten sejajar tengah
        children: [
          // ✅ Tombol ceklis di kiri
          GestureDetector(
            behavior: HitTestBehavior.opaque, // biar area klik lebih responsif
            onTap: () {
              setState(() {
                isChecked = !isChecked;
              });
            },
            child: Container(
              padding: const EdgeInsets.all(4), // memperluas area klik
              color: Colors.transparent, // biar area bisa menerima tap
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color:
                  isChecked ? const Color(0xFFE2BE7F) : Colors.transparent,
                  border: Border.all(color: Colors.white, width: 1.8),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: isChecked
                    ? const Icon(Icons.check, size: 16, color: Colors.black)
                    : null,
              ),
            ),
          ),

          // 🕌 Nama & arabic — posisinya dibuat lebih ke tengah
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center, // ✅ tengah horizontal
              children: [
                Text(
                  widget.arabic,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontFamily: 'Reem Kufi',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontFamily: 'Aref Ruqaa Ink',
                  ),
                ),
              ],
            ),
          ),

          // 🌟 Nomor dalam bintang
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset('assets/icons/Group.png', width: 48),
              Text(
                widget.number,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Aref Ruqaa Ink',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
