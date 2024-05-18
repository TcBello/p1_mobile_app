import 'package:p1_mobile_app/model/entities/hive_cart_entity.dart';
import 'package:p1_mobile_app/model/entities/product_entity.dart';

abstract class BaseCart {
  List<HiveCartEntity> fetchData();
  Future<List<HiveCartEntity>> updateQuantity(
      HiveCartEntity cart, int newQuantity);
  Future<bool> addToCart(ProductEntity product);
  Future<List<HiveCartEntity>> removeItem(int cartItemId);
}
