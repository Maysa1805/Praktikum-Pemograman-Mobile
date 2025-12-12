class HijriDate {
  final String day;
  final String month;
  final String year;

  HijriDate({
    required this.day,
    required this.month,
    required this.year,
  });

  factory HijriDate.fromJson(Map<String, dynamic> json) {
    return HijriDate(
      day: json['day'],
      month: json['month']['en'],
      year: json['year'],
    );
  }
}
