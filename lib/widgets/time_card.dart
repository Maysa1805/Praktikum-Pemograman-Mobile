import 'package:flutter/material.dart';

class TimeCard extends StatelessWidget {
  final String name;
  final String time;
  final String meridiem;
  final bool highlight;

  const TimeCard({
    super.key,
    required this.name,
    required this.time,
    required this.meridiem,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 86,
      height: 106,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: highlight
            ? const LinearGradient(
          colors: [Color(0xFF846B3F), Color(0xFF202020)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )
            : const LinearGradient(
          colors: [Color(0xFF202020), Color(0xFF846B3F)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'Janna LT',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            time,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontFamily: 'Janna LT',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            meridiem,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'Janna LT',
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
