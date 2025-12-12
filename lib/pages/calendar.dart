import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:ramadhan_app/services/hijri_service.dart';
import 'package:ramadhan_app/widgets/bottom_navbar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  Map<DateTime, List<String>> islamicEvents = {};
  TextEditingController searchController = TextEditingController();

  bool loading = true;
  bool loadingHijri = false;
  bool searching = false;

  Map<String, dynamic>? selectedHijriDate;

  /// 🔍 Hasil pencarian tahun ini + tahun depan
  List<Map<String, dynamic>> searchResults = [];

  final List<String> popularKeywords = [
    "Ramadhan",
    "Idul Fitri",
    "Idul Adha",
    "Maulid Nabi",
    "Isra Mi'raj",
    "Tahun Baru Islam",
    "Asyura",
    "Nuzulul Quran",
    "Arafah",
    "Tarwiyah",
    "Lailatul Qadar",
    "Rajab",
    "Syaban",
    "Muharram",
    "Hijriyah"
  ];

  @override
  void initState() {
    super.initState();
    loadCalendarData();
  }

  Future<void> loadCalendarData() async {
    loading = true;
    setState(() {});

    Map<DateTime, List<String>> rawEvents =
    await HijriService.fetchHijriEvents(focusedDay.month, focusedDay.year);

    Map<DateTime, List<String>> normalized = {};

    rawEvents.forEach((date, events) {
      DateTime key = DateTime(date.year, date.month, date.day);
      normalized[key] = events;
    });

    islamicEvents = normalized;

    loading = false;
    setState(() {});
  }

  Future<void> loadHijriDate(DateTime date) async {
    setState(() => loadingHijri = true);

    try {
      final hijriService = HijriService();
      final hijriData = await hijriService.getHijriDate(date);

      setState(() {
        selectedHijriDate = hijriData;
        loadingHijri = false;
      });
    } catch (e) {
      setState(() {
        selectedHijriDate = null;
        loadingHijri = false;
      });
    }
  }

  // =====================================================
  //  🔍 HELPER: Matching yang lebih fleksibel
  // =====================================================
  bool matchKeyword(String event, String keyword) {
    // Normalisasi: lowercase dan remove extra spaces
    String normalizedEvent = event.toLowerCase().trim().replaceAll(RegExp(r'\s+'), ' ');
    String normalizedKeyword = keyword.toLowerCase().trim().replaceAll(RegExp(r'\s+'), ' ');

    // Coba exact match
    if (normalizedEvent.contains(normalizedKeyword)) return true;

    // Coba partial word match - untuk handle variasi ejaan
    List<String> eventWords = normalizedEvent.split(' ');
    List<String> keywordWords = normalizedKeyword.split(' ');

    for (var kw in keywordWords) {
      if (kw.length < 3) continue; // Skip kata terlalu pendek

      for (var ew in eventWords) {
        if (ew.contains(kw) || kw.contains(ew)) {
          return true;
        }
      }
    }

    return false;
  }

  // =====================================================
  //  🔍 SEARCH: Tahun Ini + Tahun Depan (IMPROVED)
  // =====================================================
  Future<void> searchEvent() async {
    String keyword = searchController.text.trim().toLowerCase();

    if (keyword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Masukkan keyword pencarian"),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      searching = true;
      searchResults.clear();
    });

    int currentYear = DateTime.now().year;
    int nextYear = currentYear + 1;

    debugPrint("🔍 Searching for: '$keyword'");

    // SCAN =====================================================
    Future<void> scanYear(int year) async {
      debugPrint("📅 Scanning year: $year");

      for (int month = 1; month <= 12; month++) {
        try {
          Map<DateTime, List<String>> events =
          await HijriService.fetchHijriEvents(month, year);

          // 🔍 DEBUG: Print semua event yang didapat
          if (events.isNotEmpty) {
            debugPrint("  Month $month/$year has ${events.length} dates with events");
          }

          events.forEach((date, listEvents) {
            // Normalisasi tanggal → Pakai tahun yang sedang discan
            final normalized = DateTime(year, date.month, date.day);

            for (var ev in listEvents) {
              // 🔍 DEBUG: Cek matching
              bool isMatch = matchKeyword(ev, keyword);

              if (isMatch) {
                debugPrint("  ✅ MATCH: '$ev' on $normalized");

                bool duplicate = searchResults.any((item) =>
                item["event"] == ev &&
                    item["date"].day == normalized.day &&
                    item["date"].month == normalized.month &&
                    item["date"].year == normalized.year);

                if (!duplicate) {
                  searchResults.add({
                    "year": year,
                    "date": normalized,
                    "event": ev,
                  });
                }
              }
            }
          });
        } catch (e) {
          debugPrint("❌ Error fetching events for $month/$year: $e");
        }
      }
    }

    // Tahun ini
    await scanYear(currentYear);

    // Tahun depan
    await scanYear(nextYear);

    // Sort
    searchResults.sort(
            (a, b) => (a["date"] as DateTime).compareTo(b["date"] as DateTime));

    debugPrint("🎯 Total results found: ${searchResults.length}");

    setState(() {
      searching = false;
    });

    if (searchResults.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Tidak ditemukan hasil untuk '$keyword'"),
          backgroundColor: Colors.grey[700],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Kalender Hijriyah"),
        backgroundColor: const Color(0xFFC0A37C),
        elevation: 0,
      ),
      bottomNavigationBar: const BottomNavBar(),
      body: loading
          ? const Center(
        child: CircularProgressIndicator(color: Color(0xFFC0A37C)),
      )
          : Column(
        children: [
          // SEARCH BAR
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: "Cari hari besar Islam…",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFFC0A37C),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFFC0A37C),
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFFC0A37C),
                          width: 1.5,
                        ),
                      ),
                    ),
                    onSubmitted: (_) => searchEvent(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: searching ? null : searchEvent,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC0A37C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(14),
                  ),
                  child: searching
                      ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                      : const Icon(Icons.search, color: Colors.white),
                ),
              ],
            ),
          ),

          // Suggested keywords
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: popularKeywords.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ActionChip(
                    label: Text(
                      popularKeywords[index],
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFFC0A37C),
                      ),
                    ),
                    backgroundColor: Colors.white,
                    side: const BorderSide(
                      color: Color(0xFFC0A37C),
                      width: 1,
                    ),
                    onPressed: searching
                        ? null
                        : () {
                      searchController.text =
                      popularKeywords[index];
                      searchEvent();
                    },
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          // ======================================================
          //  HASIL PENCARIAN (UPDATED)
          // ======================================================
          if (searchResults.isNotEmpty || searching)
            Expanded(
              child: searching
                  ? const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(
                        color: Color(0xFFC0A37C)),
                    SizedBox(height: 16),
                    Text(
                      "Mencari hari besar Islam...",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              )
                  : Column(
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Ditemukan ${searchResults.length} hasil",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              searchResults.clear();
                              searchController.clear();
                            });
                          },
                          child: const Text(
                            "Tutup",
                            style: TextStyle(
                                color: Color(0xFFC0A37C)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12),
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        final item = searchResults[index];
                        final date = item["date"] as DateTime;
                        final event = item["event"] as String;
                        final year = item["year"] as int;

                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(12),
                          ),
                          elevation: 3,
                          margin:
                          const EdgeInsets.only(bottom: 12),
                          child: InkWell(
                            borderRadius:
                            BorderRadius.circular(12),
                            onTap: () {
                              setState(() {
                                selectedDay = date;
                                focusedDay = date;
                                searchResults.clear();
                                searchController.clear();
                              });
                              loadCalendarData();
                              loadHijriDate(date);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Container(
                                    padding:
                                    const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFC0A37C)
                                          .withOpacity(0.1),
                                      borderRadius:
                                      BorderRadius.circular(10),
                                    ),
                                    child: const Icon(
                                      Icons.event,
                                      color: Color(0xFFC0A37C),
                                      size: 28,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          event,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight:
                                            FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.calendar_today,
                                              size: 14,
                                              color: Colors.grey,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              "${date.day}/${date.month}/$year",
                                              style:
                                              const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )

          // ======================================================
          // KALENDER NORMAL
          // ======================================================
          else ...[
            TableCalendar(
              focusedDay: focusedDay,
              firstDay: DateTime(2000),
              lastDay: DateTime(2050),
              selectedDayPredicate: (day) => isSameDay(day, selectedDay),
              eventLoader: (day) {
                DateTime key = DateTime(day.year, day.month, day.day);
                return islamicEvents[key] ?? [];
              },
              onDaySelected: (sel, foc) {
                setState(() {
                  selectedDay = sel;
                  focusedDay = foc;
                });
                loadHijriDate(sel);
              },
              onPageChanged: (newDay) {
                focusedDay = newDay;
                loadCalendarData();
              },
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: const Color(0xFFC0A37C).withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: const BoxDecoration(
                  color: Color(0xFFC0A37C),
                  shape: BoxShape.circle,
                ),
                markerDecoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(height: 10),
            if (selectedDay != null)
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFC0A37C).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFC0A37C),
                    width: 1,
                  ),
                ),
                child: loadingHijri
                    ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Color(0xFFC0A37C),
                    strokeWidth: 2,
                  ),
                )
                    : selectedHijriDate != null
                    ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.calendar_today,
                            color: Color(0xFFC0A37C), size: 20),
                        SizedBox(width: 8),
                        Text(
                          "Tanggal Hijriyah",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "${selectedHijriDate!['day']} ${selectedHijriDate!['month']['en']} ${selectedHijriDate!['year']} H",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFC0A37C),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${selectedHijriDate!['day']} ${selectedHijriDate!['month']['ar']} ${selectedHijriDate!['year']} هـ",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                )
                    : const Text(
                  "Gagal memuat tanggal Hijriyah",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            Expanded(
              child: selectedDay != null &&
                  islamicEvents[DateTime(selectedDay!.year,
                      selectedDay!.month, selectedDay!.day)] !=
                      null
                  ? ListView(
                children: islamicEvents[DateTime(selectedDay!.year,
                    selectedDay!.month, selectedDay!.day)]!
                    .map(
                      (e) => ListTile(
                    leading: const Icon(
                      Icons.star,
                      color: Color(0xFFC0A37C),
                    ),
                    title: Text(
                      e,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
                    .toList(),
              )
                  : const Center(
                child: Text(
                  "Tidak ada hari besar Islam pada tanggal ini",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
