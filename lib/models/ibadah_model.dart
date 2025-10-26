class IbadahModel {
  final String tanggal;
  final String hijri;
  final int hariKe;
  final int sisaHari;
  final Map<String, String> hadis;

  IbadahModel({
    required this.tanggal,
    required this.hijri,
    required this.hariKe,
    required this.sisaHari,
    required this.hadis,
  });

  factory IbadahModel.fromJson(Map<String, dynamic> json) {
    return IbadahModel(
      tanggal: json['tanggal'],
      hijri: json['hijri'],
      hariKe: json['hari_ke'],
      sisaHari: json['sisa_hari'],
      hadis: Map<String, String>.from(json['hadis']),
    );
  }
}
