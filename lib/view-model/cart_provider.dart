import 'package:flutter/foundation.dart';
import 'package:p1_mobile_app/model/data/cart_repository.dart';
import 'package:p1_mobile_app/model/entities/hive_cart_entity.dart';
import 'package:p1_mobile_app/model/entities/product_entity.dart';

class CartProvider extends ChangeNotifier {
  final _cartRepo = CartRepository();

  List<HiveCartEntity> _cartItems = <HiveCartEntity>[];
  List<HiveCartEntity> get cartItems => _cartItems;

  Future<void> updateQuantity(HiveCartEntity cart, int newQuantity) async {
    _cartItems = await _cartRepo.updateQuantity(cart, newQuantity);
    notifyListeners();
  }

  Future<bool> addToCart(ProductEntity product) {
    return _cartRepo.addToCart(product);
  }

  void fetchData() {
    var data = _cartRepo.fetchData();
    _cartItems = data;
  }

  Future<void> removeItem(int cartItemId) async {
    var data = await _cartRepo.removeItem(cartItemId);
    _cartItems = data;
    notifyListeners();
  }
}
