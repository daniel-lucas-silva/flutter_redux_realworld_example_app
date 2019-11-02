part of utils;

serialize<T>(List list,  T Function(Map<String, dynamic>) map) => list.cast<Map<String, dynamic>>().map(map).toList();
