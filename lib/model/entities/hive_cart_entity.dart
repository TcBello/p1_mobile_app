import 'package:hive_flutter/adapters.dart';
import 'package:p1_mobile_app/model/entities/product_entity.dart';

part 'hive_cart_entity.g.dart';

@HiveType(typeId: 3)
class HiveCartEntity {
  @HiveField(0)
  final ProductEntity product;

  @HiveField(1)
  final int quantity;

  HiveCartEntity({required this.product, required this.quantity});

  HiveCartEntity copyWithQuantity(int newQuantity) {
    return HiveCartEntity(product: product, quantity: newQuantity);
  }

  static Future<void> openBox() async {
    // await Hive.openBox<List<HiveCartEntity>>('cart');
    await Hive.openBox<List>('cart');
  }

  static Future<void> put(List<HiveCartEntity> cart) async {
    bool isOpened = Hive.isBoxOpen('cart');

    if (isOpened) {
      // var box = Hive.box<List<HiveCartEntity>>('cart');
      var box = Hive.box<List>('cart');
      await box.put('cart', cart);
    }
  }

  static List<HiveCartEntity>? get() {
    bool isOpened = Hive.isBoxOpen('cart');

    if (isOpened) {
      var box = Hive.box<List>('cart');
      return box.get('cart')?.map((e) => e as HiveCartEntity).toList();
    }

    return null;
  }
}
