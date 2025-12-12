class TadarusStore {
  static final Map<String, List<Map<String, dynamic>>> _data = {};

  static void save(String tanggal, Map<String, dynamic> tadarus) {
    _data.putIfAbsent(tanggal, () => []);
    _data[tanggal]!.add(tadarus);
  }

  static Map<String, List<Map<String, dynamic>>> getAll() {
    return _data;
  }

  static List<Map<String, dynamic>> getByDate(String tanggal) {
    return _data[tanggal] ?? [];
  }
}
