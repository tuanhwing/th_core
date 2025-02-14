

import 'package:th_logger/th_logger.dart';

///THMapExtension
extension THMapExtension on Map<String, dynamic> {
  ///Parse int
  int parseInt(String key) {
    int data = 0;
    try {
      data = int.tryParse('${this[key]}') ?? 0;
    } catch(exception) {
      THLogger().e(exception.toString());
    }

    return data;
  }

  ///Parse double
  double parseDouble(String key) {
    double data = 0.0;
    try {
      data = double.tryParse('${this[key]}') ?? 0.0;
    } catch(exception) {
      THLogger().e(exception.toString());
    }

    return data;
  }

  ///Parse String
  String parseString(String key) {
    String data = '';
    try {
      data = (this[key] as String?) ?? '';
    } catch(exception) {
      THLogger().e(exception.toString());
    }

    return data;
  }

  ///Parse bool
  bool parseBool(String key) {
    bool data = false;
    try {
      data = bool.tryParse('${this[key]}') ?? false;
    } catch(exception) {
      THLogger().e(exception.toString());
    }

    return data;
  }

  ///Parse Map
  Map<K,V> parseMap<K, V>(String key) {
    Map<K, V> data = <K, V>{};
    try {
      final dynamic map = this[key];
      if (map is Map) {
        data = Map<K,V>.from(map);
      }
    } catch(exception) {
      THLogger().e(exception.toString());
    }

    return data;
  }

  ///Parse List
  List<T> parseList<T>(String key) {
    List<T> data = <T>[];
    try {
      final dynamic list = this[key];
      if (list is List) {
        data = List<T>.from(list);
      }
    } catch(exception) {
      THLogger().e(exception.toString());
    }

    return data;
  }
}
