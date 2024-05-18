import 'package:flutter/foundation.dart';
import 'package:p1_mobile_app/constants/constant_fake_store_api_routes.dart';
import 'package:p1_mobile_app/model/entities/product_entity.dart';
import 'package:p1_mobile_app/model/repositories/base_products.dart';
import 'package:dio/dio.dart';
import 'package:p1_mobile_app/utils/toast_util.dart';

class ProductRepository implements BaseProduct {
  final _dio = Dio();

  @override
  Future<List<ProductEntity>?> fetchProducts() async {
    try {
      var response = await _dio.get(ConstantFakeStoreApiRoutes.fetchRoute);

      if (response.statusCode != null && response.statusCode == 200) {
        List<dynamic> rawData = response.data;

        return rawData
            .map((e) => ProductEntity.fromJSON(e as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      debugPrint(e.toString());
      ToastUtil.showLong(e.toString());
    }

    return null;
  }
}
