// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// final localSecureStorageProvider = Provider(
//   ((ref) => LocalSecureStorageRepository()),
// );

// class LocalSecureStorageRepository {
//   void setToken(String token) async {
//     const storage = FlutterSecureStorage();
//     await storage.write(key: 'x-auth-token', value: token);
//   }

//   Future<String?> getToken() async {
//     const storage = FlutterSecureStorage();
//     String? token = await storage.read(key: 'x-auth-token');
//     return token;
//   }
// }
