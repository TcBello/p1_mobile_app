import 'package:flutter/widgets.dart';
import 'package:p1_mobile_app/model/entities/hive_cart_entity.dart';
import 'package:p1_mobile_app/model/entities/product_entity.dart';
import 'package:p1_mobile_app/model/repositories/base_cart.dart';
import 'package:p1_mobile_app/utils/toast_util.dart';

class CartRepository implements BaseCart {
  @override
  Future<List<HiveCartEntity>> updateQuantity(
      HiveCartEntity cart, int newQuantity) async {
    try {
      var currentCart = HiveCartEntity.get() ?? <HiveCartEntity>[];

      if (currentCart.isNotEmpty) {
        int currentIndex = currentCart
            .indexWhere((element) => element.product.id == cart.product.id);

        currentCart[currentIndex] = cart.copyWithQuantity(newQuantity);

        await HiveCartEntity.put(currentCart);

        return currentCart;
      }
    } catch (e) {
      debugPrint(e.toString());
      ToastUtil.showLong(e.toString());
    }

    return [];
  }

  @override
  Future<bool> addToCart(ProductEntity product) async {
    try {
      var currentCart = HiveCartEntity.get() ?? <HiveCartEntity>[];
      var cartItem = HiveCartEntity(product: product, quantity: 1);
      currentCart.add(cartItem);
      await HiveCartEntity.put(currentCart);

      return true;
    } catch (e) {
      debugPrint(e.toString());
      ToastUtil.showLong(e.toString());
    }

    return false;
  }

  @override
  List<HiveCartEntity> fetchData() {
    try {
      var currentCart = HiveCartEntity.get() ?? <HiveCartEntity>[];
      return currentCart;
    } catch (e) {
      debugPrint(e.toString());
      ToastUtil.showLong(e.toString());
    }

    return <HiveCartEntity>[];
  }

  @override
  Future<List<HiveCartEntity>> removeItem(int cartItemId) async {
    try {
      var currentCart = HiveCartEntity.get() ?? <HiveCartEntity>[];
      currentCart.removeWhere((element) => element.product.id == cartItemId);
      await HiveCartEntity.put(currentCart);

      return currentCart;
    } catch (e) {
      debugPrint(e.toString());
      ToastUtil.showLong(e.toString());
    }

    return <HiveCartEntity>[];
  }
}
