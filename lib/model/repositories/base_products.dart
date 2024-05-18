import 'package:p1_mobile_app/model/entities/product_entity.dart';

abstract class BaseProduct {
  Future<List<ProductEntity>?> fetchProducts();
}
