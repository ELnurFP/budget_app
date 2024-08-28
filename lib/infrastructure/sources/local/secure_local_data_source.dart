import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final _secureStorageProvider = Provider<FlutterSecureStorage>(
  (ref) {
    return const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    );
  },
);

final secureLocalDataSourceProvider = Provider<SecureLocalDataSource>(
  (ref) {
    return SecureLocalDataSource(
      secureStorage: ref.read(_secureStorageProvider),
    );
  },
);

class SecureLocalDataSource {
  final FlutterSecureStorage secureStorage;

  SecureLocalDataSource({
    required this.secureStorage,
  });

  Future<void> deleteAll() {
    return secureStorage.deleteAll();
  }

  Future<String?> read(String key) async {
    if (await containsKey(key: key)) {
      return secureStorage.read(key: key);
    } else {
      return null;
    }
  }

  Future<void> write(String key, String value) async {
    await secureStorage.write(key: key, value: value);
  }

  Future<void> delete({required String key}) async {
    await secureStorage.delete(key: key);
  }

  Future<bool> containsKey({required String key}) {
    return secureStorage.containsKey(key: key);
  }
}
