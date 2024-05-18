import 'package:flutter/widgets.dart';
import 'package:p1_mobile_app/model/data/product_repository.dart';
import 'package:p1_mobile_app/model/entities/product_entity.dart';

class ProductProvider extends ChangeNotifier {
  final _productRepo = ProductRepository();

  Future<List<ProductEntity>?> fetchProducts() {
    return _productRepo.fetchProducts();
  }
}
