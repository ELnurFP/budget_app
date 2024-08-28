import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) {
    throw UnimplementedError();
  },
);

final preferencesLocalDataSourceProvider = Provider<PreferencesLocalDataSource>(
  (ref) {
    return PreferencesLocalDataSource(
      sharedPreferences: ref.read(sharedPreferencesProvider),
    );
  },
);

class PreferencesLocalDataSource {
  final SharedPreferences sharedPreferences;

  PreferencesLocalDataSource({
    required this.sharedPreferences,
  });

  Future<void> deleteAll() {
    return sharedPreferences.clear();
  }

  T? get<T>(String key) {
    return sharedPreferences.get(key) as T?;
  }

  Future<bool> set<T>(String key, T value) {
    if (value is bool) {
      return sharedPreferences.setBool(key, value);
    } else if (value is int) {
      return sharedPreferences.setInt(key, value);
    } else if (value is double) {
      return sharedPreferences.setDouble(key, value);
    } else if (value is String) {
      return sharedPreferences.setString(key, value);
    } else if (value is List<String>) {
      return sharedPreferences.setStringList(key, value);
    } else {
      throw UnimplementedError();
    }
  }

  Future<bool> delete(String key) {
    return sharedPreferences.remove(key);
  }
}
