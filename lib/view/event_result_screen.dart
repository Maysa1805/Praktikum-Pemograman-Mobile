import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventResultScreen extends StatelessWidget {
  final List<Map<String, dynamic>> results;

  const EventResultScreen({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hasil Pencarian"),
        backgroundColor: Colors.green,
      ),
      body: results.isEmpty
          ? const Center(
        child: Text(
          "Tidak ada hasil ditemukan",
          style: TextStyle(fontSize: 16),
        ),
      )
          : ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, i) {
          DateTime d = results[i]["date"];
          String event = results[i]["event"];

          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: const Icon(Icons.event, color: Colors.green),
              title: Text(event),
              subtitle: Text(DateFormat("dd MMMM yyyy").format(d)),
            ),
          );
        },
      ),
    );
  }
}
