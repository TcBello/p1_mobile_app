import 'package:flutter/material.dart';
import 'package:p1_mobile_app/model/entities/hive_cart_entity.dart';
import 'package:p1_mobile_app/view-model/cart_provider.dart';
import 'package:provider/provider.dart';

class CartItem extends StatefulWidget {
  const CartItem({super.key, required this.cartItem});

  final HiveCartEntity cartItem;

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  late CartProvider _cartProvider;

  late ValueNotifier<int> _quantityNotifier;

  final double _imageSize = 100;

  @override
  void initState() {
    _cartProvider = context.read<CartProvider>();
    _quantityNotifier = ValueNotifier(widget.cartItem.quantity);
    super.initState();
  }

  @override
  void dispose() {
    _quantityNotifier.dispose();
    super.dispose();
  }

  void _handleRemove() {
    _cartProvider.removeItem(widget.cartItem.product.id);
  }

  void _handleIncrement() {
    _quantityNotifier.value += 1;
    _cartProvider.updateQuantity(widget.cartItem, _quantityNotifier.value);
  }

  void _handleDecrement() {
    if (_quantityNotifier.value > 1) {
      _quantityNotifier.value -= 1;
      _cartProvider.updateQuantity(widget.cartItem, _quantityNotifier.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;

          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    SizedBox(
                      height: _imageSize,
                      width: _imageSize,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(widget.cartItem.product.image),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: maxWidth * 0.6,
                          child: Text(
                            widget.cartItem.product.title,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontSize: 16),
                          ),
                        ),
                        Text(
                          "\$${widget.cartItem.product.price}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: _handleDecrement,
                              icon: const Icon(Icons.remove),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            ValueListenableBuilder<int>(
                              valueListenable: _quantityNotifier,
                              builder: (context, value, child) {
                                return Text(value.toString());
                              },
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: _handleIncrement,
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 0,
                child: IconButton(
                  onPressed: _handleRemove,
                  icon: const Icon(Icons.close),
                  style: const ButtonStyle(
                      foregroundColor: MaterialStatePropertyAll(Colors.red)),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
