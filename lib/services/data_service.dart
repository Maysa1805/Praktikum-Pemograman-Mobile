import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/ibadah_model.dart';

class DataService {
  Future<IbadahModel> loadData() async {
    // Pastikan path cocok dengan pubspec.yaml
    final response = await rootBundle.loadString('assets/data/dummy_data.json');
    final data = jsonDecode(response);
    return IbadahModel.fromJson(data);
  }
}
