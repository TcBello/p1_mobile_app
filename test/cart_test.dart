import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:p1_mobile_app/model/data/cart_repository.dart';
import 'package:p1_mobile_app/model/entities/hive_cart_entity.dart';
import 'package:p1_mobile_app/model/entities/product_entity.dart';
import 'package:p1_mobile_app/model/entities/rating_entity.dart';

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
  Hive.registerAdapter(ProductEntityAdapter());
  Hive.registerAdapter(RatingEntityAdapter());
  Hive.registerAdapter(HiveCartEntityAdapter());
  await HiveCartEntity.openBox();

  final cartRepo = CartRepository();

  Map<String, dynamic> rawProduct = {
    "id": 1,
    "title": "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
    "price": 109.95,
    "description":
        "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
    "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
    "rating": {"rate": 3.9, "count": 120}
  };

  test("Add To Cart", () async {
    // ACT
    bool isAdded = await cartRepo.addToCart(ProductEntity.fromJSON(rawProduct));

    // ASSERT
    expect(isAdded, true);
  });

  test("Fetch Cart Data", () {
    // ACT
    var cartItems = cartRepo.fetchData();

    // ASSERT
    expect(cartItems.isNotEmpty, true);
  });

  test("Update Product Quantity", () async {
    // ARRANGE
    var hiveCart = HiveCartEntity(
        product: ProductEntity.fromJSON(rawProduct), quantity: 2);
    int targetQuantity = 10;

    // ACT
    var cartItems = await cartRepo.updateQuantity(hiveCart, targetQuantity);
    var currentItem = cartItems
        .singleWhere((element) => element.product.id == hiveCart.product.id);

    // ASSERT
    expect(currentItem.quantity == targetQuantity, true);
  });

  test("Remove Cart Item", () async {
    // ARRANGE
    var product = ProductEntity.fromJSON(rawProduct);

    // ACT
    var cartItems = await cartRepo.removeItem(product.id);
    bool isRemoved =
        cartItems.where((element) => element.product.id == product.id).isEmpty;

    // ASSERT
    expect(isRemoved, true);
  });
}
