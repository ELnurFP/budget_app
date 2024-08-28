import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_budget_app/budget_app.dart';

final simpleCacheRepositoryProvider = Provider<SimpleCacheRepository>(
  (ref) {
    return SimpleCacheRepository(
      preferencesLocalDataSource: ref.read(preferencesLocalDataSourceProvider),
      secureLocalDataSource: ref.read(secureLocalDataSourceProvider),
    );
  },
);

const String _isFirstLaunch = 'is_first_launch';
const String _token = 'token';
const String _phoneNumber = 'phone_number';

class SimpleCacheRepository {
  final PreferencesLocalDataSource preferencesLocalDataSource;
  final SecureLocalDataSource secureLocalDataSource;

  SimpleCacheRepository({
    required this.preferencesLocalDataSource,
    required this.secureLocalDataSource,
  });

  // is first launch
  Future<void> setIsFirstLaunch(bool isFirstLaunch) {
    return preferencesLocalDataSource.set(_isFirstLaunch, isFirstLaunch);
  }

  bool getIsFirstLaunch() {
    return preferencesLocalDataSource.get<bool>(_isFirstLaunch) == null;
  }

  // token
  Future<void> setToken(String token) {
    return secureLocalDataSource.write(_token, token);
  }

  Future<String?> getToken() {
    return secureLocalDataSource.read(_token);
  }

  // phone number
  Future<void> setPhoneNumber(String phoneNumber) {
    return preferencesLocalDataSource.set(_phoneNumber, phoneNumber);
  }

  String? getPhoneNumber() {
    return preferencesLocalDataSource.get<String>(_phoneNumber);
  }

  Future<void> deleteAll() async {
    await preferencesLocalDataSource.deleteAll();
    await secureLocalDataSource.deleteAll();
  }

  Future<void> deleteAllSecure() {
    return secureLocalDataSource.deleteAll();
  }
}
