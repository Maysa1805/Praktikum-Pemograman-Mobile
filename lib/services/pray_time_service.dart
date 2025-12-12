// pray_time_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class PrayTimeService {
  /// Default city id: 1301 = Jakarta Pusat
  final int cityId;
  PrayTimeService({this.cityId = 1301});

  /// Fetch schedule for given date (default today).
  /// Returns a Map with keys similar to your old local JSON:
  /// {
  ///   'date': '2025-12-12',
  ///   'day': 'Friday',
  ///   'hijri': '...optional...',
  ///   'times': [ { 'name': 'Subuh', 'time': '04:22', 'meridiem': 'AM', 'highlight': false }, ... ],
  ///   'next_pray': 'Dzuhur'
  /// }
  Future<Map<String, dynamic>> fetchSchedule({DateTime? date}) async {
    final now = date ?? DateTime.now();
    final y = now.year;
    final m = now.month;
    final d = now.day;

    final url =
        'https://api.myquran.com/v2/sholat/jadwal/$cityId/$y/$m/$d'; // MyQuran v2 endpoint

    final resp = await http.get(Uri.parse(url));
    if (resp.statusCode != 200) {
      throw Exception('Failed to load pray times (status ${resp.statusCode})');
    }

    final Map<String, dynamic> jsonBody = json.decode(resp.body);

    // Defensive: MyQuran structure sometimes nests in 'data'
    final data = jsonBody['data'] ?? jsonBody;

    // Try to extract jadwal object
    final jadwal = data['jadwal'] ?? data;

    // Extract times - fallbacks in case keys differ
    String fajr = _safeString(jadwal, ['fajr', 'subuh', 'imsyak']);
    String dhuhr = _safeString(jadwal, ['dhuhr', 'dzuhur', 'zhuhur']);
    String asr = _safeString(jadwal, ['asr', 'ashar']);
    String maghrib = _safeString(jadwal, ['maghrib']);
    String isya = _safeString(jadwal, ['isha', 'isya']);

    // Date and day
    String dateStr = jadwal['date'] ??
        data['date'] ??
        DateFormat('yyyy-MM-dd').format(now); // fallback ISO date
    String dayStr = DateFormat('EEEE').format(now); // English day name
    // Try to find hijri in response (structure may vary); fallback empty string
    String hijri = '';
    try {
      if (data.containsKey('date') && data['date'] is Map) {
        final dateObj = data['date'];
        if (dateObj.containsKey('hijri')) {
          final hj = dateObj['hijri'];
          // attempt a few common fields:
          hijri = hj['date'] ?? hj['tanggal'] ?? hj.toString();
        }
      }
    } catch (_) {
      hijri = '';
    }

    // Build times list in the UI order the user chose: Subuh, Dzuhur, Ashar, Maghrib, Isya
    final times = [
      {'key': 'fajr', 'name': 'Subuh', 'time': fajr},
      {'key': 'dhuhr', 'name': 'Dzuhur', 'time': dhuhr},
      {'key': 'asr', 'name': 'Ashar', 'time': asr},
      {'key': 'maghrib', 'name': 'Maghrib', 'time': maghrib},
      {'key': 'isya', 'name': 'Isya', 'time': isya},
    ];

    // Determine next pray by comparing now with times (using local device timezone)
    final nowLocal = DateTime.now();
    String nextName = times.last['name']!; // default last
    for (final t in times) {
      final parsed = _parseTimeToDateTime(nowLocal, t['time'] as String);
      if (parsed != null && parsed.isAfter(nowLocal)) {
        nextName = t['name']!;
        break;
      }
    }

    // Format times with meridiem and highlight
    final formattedTimes = times.map((t) {
      final raw = t['time'] as String;
      final mer = _getMeridiem(raw);
      return {
        'name': t['name'],
        'time': raw,
        'meridiem': mer,
        'highlight': t['name'] == nextName,
      };
    }).toList();

    return {
      'date': dateStr,
      'day': dayStr,
      'hijri': hijri,
      'times': formattedTimes,
      'next_pray': nextName,
    };
  }

  // Helpers

  String _safeString(Map m, List<String> keys) {
    for (final k in keys) {
      if (m.containsKey(k) && m[k] != null && m[k].toString().trim().isNotEmpty) {
        return m[k].toString();
      }
    }
    return '';
  }

  /// Parse HH:mm (or HH:mm:ss) into DateTime with today's date (local timezone).
  DateTime? _parseTimeToDateTime(DateTime base, String timeStr) {
    try {
      final parts = timeStr.split(':');
      if (parts.length < 2) return null;
      final h = int.parse(parts[0]);
      final min = int.parse(parts[1]);
      return DateTime(base.year, base.month, base.day, h, min);
    } catch (_) {
      return null;
    }
  }

  /// Return AM/PM string for the given HH:mm string
  String _getMeridiem(String timeStr) {
    final dt = _parseTimeToDateTime(DateTime.now(), timeStr);
    if (dt == null) return '';
    return dt.hour >= 12 ? 'PM' : 'AM';
  }
}
