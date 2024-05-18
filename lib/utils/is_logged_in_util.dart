import 'package:hive_flutter/hive_flutter.dart';

class IsLoggedInUtil {
  static Future<void> init() async {
    var box = await Hive.openBox<bool>('isLoggedIn');
    var currentData = box.get('isLoggedIn');

    if (currentData == null) {
      await box.put('isLoggedIn', false);
    }
  }

  static bool isLoggedIn() {
    var box = Hive.box<bool>('isLoggedIn');

    return box.get('isLoggedIn') ?? false;
  }

  static Future<void> setIsLogin(bool value) async {
    var box = Hive.box<bool>('isLoggedIn');
    await box.put('isLoggedIn', value);
  }
}
