import 'package:flutter/material.dart';
import 'package:p1_mobile_app/model/entities/product_entity.dart';

class OrderSummaryItem extends StatelessWidget {
  const OrderSummaryItem(
      {super.key, required this.product, required this.quantity});

  final ProductEntity product;
  final int quantity;

  final double _imageSize = 50;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        width: _imageSize,
        height: _imageSize,
        child: Image.network(product.image),
      ),
      title: Text(
        product.title,
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
      subtitle: Text("Quantity: $quantity"),
      trailing: Text(
        "\$${product.price}",
        style: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
