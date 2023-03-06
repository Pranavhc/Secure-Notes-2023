import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final hiveDbProvider = Provider(
  ((ref) => HiveDBRepository()),
);

class HiveDBRepository {
  void setToken(String token) {
    var settings = Hive.box('local-data');
    settings.put('x-auth-token', token);
  }

  String getToken() {
    var settings = Hive.box('local-data');
    return settings.get('x-auth-token');
  }

  void setView(String view) {
    var settings = Hive.box('local-data');
    settings.put('view', view);
  }

  String getView() {
    var settings = Hive.box('local-data');
    return settings.get('view', defaultValue: 'list');
  }

  void setTheme(String theme) {
    var settings = Hive.box('local-data');
    settings.put('theme', theme);
  }

  String getTheme() {
    var settings = Hive.box('local-data');
    return settings.get('theme', defaultValue: 'light');
  }
}
