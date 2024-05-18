import 'package:hive_flutter/adapters.dart';

part 'hive_user_entity.g.dart';

@HiveType(typeId: 0)
class HiveUserEntity {
  @HiveField(0)
  final String email;

  @HiveField(1)
  final String password;

  HiveUserEntity({required this.email, required this.password});

  static Future<void> openBox() async {
    await Hive.openBox<List>('users');
  }

  static Future<void> put(HiveUserEntity user) async {
    bool isOpened = Hive.isBoxOpen('users');

    if (isOpened) {
      var box = Hive.box<List>('users');
      var currentUsers =
          box.get('users')?.map((e) => e as HiveUserEntity).toList() ??
              <HiveUserEntity>[];
      await box.put('users', [...currentUsers, user]);
    }
  }

  static List<HiveUserEntity>? get() {
    bool isOpened = Hive.isBoxOpen('users');

    if (isOpened) {
      var box = Hive.box<List>('users');
      return box.get('users')?.map((e) => e as HiveUserEntity).toList();
    }

    return null;
  }
}
