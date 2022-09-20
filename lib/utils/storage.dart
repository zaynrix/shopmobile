import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  FlutterSecureStorage secureStorage = FlutterSecureStorage();

  Storage({required this.secureStorage});

  final _storage = FlutterSecureStorage();

  Future<String?> secureRead(String key) async {
    String? value = await _storage.read(key: key);
    return value;
  }

  Future<void> secureDelete(String key) async {
    await _storage.delete(key: key);
  }

  Future<void> secureWrite(String key, String value) async {
    await _storage.write(key: key, value: value);
  }
}
