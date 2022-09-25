import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  FlutterSecureStorage secureStorage ;

  Storage({required this.secureStorage});

  // final _storage = FlutterSecureStorage();

  Future<String?> secureRead(String key) async {
    String? value = await secureStorage.read(key: key);
    return value;
  }

  Future<void> secureDelete(String key) async {
    await secureStorage.delete(key: key);
  }

  Future<void> secureWrite(String key, String value) async {
    await secureStorage.write(key: key, value: value);
  }
}
