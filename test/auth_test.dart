import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:p1_mobile_app/model/data/auth_repository.dart';
import 'package:p1_mobile_app/model/entities/hive_user_entity.dart';
import 'package:p1_mobile_app/utils/is_logged_in_util.dart';

void main() async {
  // ARRANGE
  TestWidgetsFlutterBinding.ensureInitialized();

  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(
          const MethodChannel('plugins.flutter.io/path_provider'),
          (MethodCall methodCall) async {
    return '.';
  });

  await Hive.initFlutter();
  Hive.registerAdapter(HiveUserEntityAdapter());
  await HiveUserEntity.openBox();
  await IsLoggedInUtil.init();

  final authRepo = AuthRepository();

  test("Register", () async {
    // ACT
    bool isRegistered = await authRepo.register("test@gmail.com", "000000");
    // ASSERT
    expect(isRegistered, true);
  });

  test("Login", () async {
    // ACT
    bool isLoggedIn = await authRepo.login("test@gmail.com", "000000");
    // ASSERT
    expect(isLoggedIn, true);
  });
}
