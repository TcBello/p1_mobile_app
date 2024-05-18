import 'package:flutter_test/flutter_test.dart';
import 'package:p1_mobile_app/model/data/product_repository.dart';

void main() {
  // ARRANGE
  final productRepo = ProductRepository();
  test("Fetch Products", () async {
    // ACT
    var products = await productRepo.fetchProducts();
    // ASSERT
    expect(products?.length, 10);
  });
}
