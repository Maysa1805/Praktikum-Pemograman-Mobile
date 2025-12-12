class IbadahTambahanStore {
  static final Map<String, List<Map<String, dynamic>>> _data = {};

  static void save(String tanggal, List<Map<String, dynamic>> ibadah) {
    _data[tanggal] = ibadah;
  }

  static Map<String, List<Map<String, dynamic>>> getAll() {
    return _data;
  }

  static List<Map<String, dynamic>> getByDate(String tanggal) {
    return _data[tanggal] ?? [];
  }
}
