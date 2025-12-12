import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class HijriService {

  // ==============================
  // CACHE AGAR SEARCH LEBIH CEPAT
  // ==============================
  static Map<String, Map<DateTime, List<String>>> _cache = {};

  // Helper: parse DD-MM-YYYY atau YYYY-MM-DD
  static DateTime? _parseDate(String? s) {
    if (s == null) return null;

    // Hilangkan whitespace
    s = s.trim();

    // Format ISO
    if (RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(s)) {
      return DateTime.tryParse(s);
    }

    // Format D-M-YYYY atau DD-MM-YYYY
    final parts = s.split('-');
    if (parts.length == 3) {
      int a = int.parse(parts[0]);
      int b = int.parse(parts[1]);
      int c = int.parse(parts[2]);

      // Jika 4 digit pertama itu tahun → YYYY-MM-DD
      if (parts[0].length == 4) {
        return DateTime(c, b, a);
      } else {
        return DateTime(c, b, a);
      }
    }

    return DateTime.tryParse(s);
  }

  // =============================================================
  // 1️⃣ Ambil hari besar Islam per bulan (untuk Calendar + Search)
  // =============================================================
  static Future<Map<DateTime, List<String>>> fetchHijriEvents(
      int month, int year) async
  {
    String key = "$month-$year";

    // 🔥 CEK CACHE
    if (_cache.containsKey(key)) {
      return _cache[key]!;
    }

    Map<DateTime, List<String>> events = {};

    try {
      final url = Uri.parse("https://api.aladhan.com/v1/gToHCalendar/$month/$year");
      final response = await http.get(url);

      if (response.statusCode != 200) return events;

      final json = jsonDecode(response.body);
      if (json["data"] == null) return events;

      for (var item in json["data"]) {
        var hijri = item["hijri"];
        if (hijri == null) continue;

        List holidayList = hijri["holidays"] ?? [];
        if (holidayList.isEmpty) continue;

        String? rawDate = item["gregorian"]?["date"];
        DateTime? parsed = _parseDate(rawDate);

        if (parsed != null) {
          events[DateTime(parsed.year, parsed.month, parsed.day)] =
              holidayList.map((e) => e.toString()).toList();

          // Debug log (bisa kamu matikan)
          if (kDebugMode) debugPrint("✔ EVENT: $rawDate → ${holidayList.join(', ')}");
        }
      }
    } catch (e) {
      if (kDebugMode) debugPrint("Error fetchHijriEvents: $e");
    }

    // Simpan ke cache
    _cache[key] = events;

    return events;
  }

  // =============================================================
  // 2️⃣ Ambil tanggal Hijriyah untuk detail hari yang dipilih
  // =============================================================
  Future<Map<String, dynamic>> getHijriDate(DateTime date) async {
    try {
      String urlDate = "${date.day}-${date.month}-${date.year}";
      final url = Uri.parse("https://api.aladhan.com/v1/gToH?date=$urlDate");

      final response = await http.get(url);
      if (response.statusCode != 200) return {};

      final json = jsonDecode(response.body);
      return json["data"]?["hijri"] ?? {};
    } catch (e) {
      if (kDebugMode) debugPrint("Error getHijriDate: $e");
      return {};
    }
  }
}
