import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final localSecureStorageProvider = Provider(
  ((ref) => LocalSecureStorageRepository()),
);

class LocalSecureStorageRepository {
  void setToken(String token) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: 'x-auth-token', value: token);
  }

  Future<String?> getToken() async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'x-auth-token');
    return token;
  }

  // void setView(String view) async {
  //   const storage = FlutterSecureStorage();
  //   await storage.write(key: 'view', value: view);
  // }

  // Future<String?> getView() async {
  //   const storage = FlutterSecureStorage();
  //   String? token = await storage.read(key: 'view');
  //   return token;
  // }

  // void setTheme(String curr) async {
  //   const storage = FlutterSecureStorage();
  //   await storage.write(key: 'is-theme-dark', value: curr);
  // }

  // Future<String?> getTheme() async {
  //   const storage = FlutterSecureStorage();
  //   return storage.read(key: 'is-theme-dark');
  // }
}
