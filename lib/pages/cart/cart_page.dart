import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:p1_mobile_app/model/entities/hive_cart_entity.dart';
import 'package:p1_mobile_app/pages/cart/components/cart_item.dart';
import 'package:p1_mobile_app/themes/app_colors.dart';
import 'package:p1_mobile_app/view-model/cart_provider.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late CartProvider _cartProvider;

  @override
  void initState() {
    _cartProvider = context.read<CartProvider>();
    _cartProvider.fetchData();
    super.initState();
  }

  void _handleCheckout(BuildContext context) {
    context.pushNamed('checkout', extra: _cartProvider.cartItems);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Selector<CartProvider, List<HiveCartEntity>>(
            selector: (_, cartProvider) => cartProvider.cartItems,
            builder: (context, cartItems, child) {
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  return CartItem(
                    cartItem: cartItems[index],
                  );
                },
              );
            }),
      ),
      bottomNavigationBar: Selector<CartProvider, List<HiveCartEntity>>(
          selector: (_, cartProvider) => cartProvider.cartItems,
          builder: (context, cartItems, child) {
            double totalPrice = 0;

            for (var item in cartItems) {
              totalPrice += item.product.price * item.quantity;
            }

            return Container(
              height: 70,
              width: size.width,
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                      text: TextSpan(
                          text: "Total: ",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.black, fontSize: 16),
                          children: [
                        TextSpan(
                            text: "\$${totalPrice.roundToDouble()}",
                            style: const TextStyle(fontWeight: FontWeight.bold))
                      ])),
                  TextButton(
                    onPressed: () =>
                        cartItems.isNotEmpty ? _handleCheckout(context) : null,
                    style: ButtonStyle(
                        foregroundColor: MaterialStatePropertyAll(
                            cartItems.isNotEmpty
                                ? Colors.white
                                : Colors.grey.shade400),
                        backgroundColor: MaterialStatePropertyAll(
                            cartItems.isNotEmpty
                                ? Colors.blue
                                : Colors.grey.shade300),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)))),
                    child: const Text("Checkout"),
                  )
                ],
              ),
            );
          }),
    );
  }
}
