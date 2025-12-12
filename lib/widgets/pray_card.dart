import 'package:flutter/material.dart';

class PrayCard extends StatelessWidget {
  final String number;
  final String name;
  final String arabic;

  final bool isChecked;            // ← baru
  final ValueChanged<bool> onChanged; // ← baru

  const PrayCard({
    super.key,
    required this.number,
    required this.name,
    required this.arabic,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ✅ Checkbox utama
          GestureDetector(
            onTap: () {
              onChanged(!isChecked);
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              color: Colors.transparent,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: isChecked ? const Color(0xFFE2BE7F) : Colors.transparent,
                  border: Border.all(color: Colors.white, width: 1.8),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: isChecked
                    ? const Icon(Icons.check, size: 16, color: Colors.black)
                    : null,
              ),
            ),
          ),

          // 🕌 Text Arab + Latin (di tengah)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  arabic,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontFamily: 'Reem Kufi',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  name,
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

          // ⭐ Nomor bintang
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset('assets/icons/Group.png', width: 48),
              Text(
                number,
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
