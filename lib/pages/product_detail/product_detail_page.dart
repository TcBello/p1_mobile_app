import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:p1_mobile_app/model/entities/hive_cart_entity.dart';
import 'package:p1_mobile_app/model/entities/product_entity.dart';
import 'package:p1_mobile_app/themes/app_colors.dart';
import 'package:p1_mobile_app/utils/toast_util.dart';
import 'package:p1_mobile_app/view-model/cart_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key, required this.product});

  final ProductEntity product;

  final double _heightBetween = 8;

  void _handleBack(BuildContext context) {
    context.pop();
  }

  void _handleBuyNow(BuildContext context) {
    context.pushNamed('checkout',
        extra: [HiveCartEntity(product: product, quantity: 1)]);
  }

  void _handleAddToCart(BuildContext context) {
    var cartProvider = context.read<CartProvider>();

    cartProvider.addToCart(product).then((value) {
      if (value) {
        ToastUtil.showShort("Added to cart");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => _handleBack(context),
          icon: const Icon(Icons.arrow_back_ios_new),
          style: const ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(Colors.white),
              backgroundColor: MaterialStatePropertyAll(Colors.blue)),
        ),
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            SizedBox(
              width: size.width,
              height: size.height * 0.5,
              child: Hero(tag: product.id, child: Image.network(product.image)),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.4,
                  ),
                  Container(
                    width: size.width,
                    constraints: BoxConstraints(minHeight: size.height * 0.6),
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                        color: AppColors.backgroundColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24))),
                    child: Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            product.title,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          trailing: Text(
                            "\$${product.price}",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            SizedBox(
                              width: _heightBetween,
                            ),
                            Text(
                              "${product.rating.rate} (${product.rating.count})",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontSize: 16),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: _heightBetween * 5,
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            "Description",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: _heightBetween,
                        ),
                        Text(
                          product.description,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontSize: 16),
                        ),
                        SizedBox(
                          height: _heightBetween * 2,
                        ),
                        SizedBox(
                          height: 50,
                          width: size.width * 0.8,
                          child: TextButton(
                            onPressed: () => _handleBuyNow(context),
                            style: ButtonStyle(
                                backgroundColor:
                                    const MaterialStatePropertyAll(Colors.blue),
                                foregroundColor: const MaterialStatePropertyAll(
                                    Colors.white),
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8)))),
                            child: const Text("Buy Now"),
                          ),
                        ),
                        SizedBox(
                          height: _heightBetween * 2,
                        ),
                        SizedBox(
                          height: 50,
                          width: size.width * 0.8,
                          child: OutlinedButton(
                            onPressed: () => _handleAddToCart(context),
                            style: ButtonStyle(
                                side: const MaterialStatePropertyAll(
                                    BorderSide(color: Colors.blue, width: 2)),
                                foregroundColor:
                                    const MaterialStatePropertyAll(Colors.blue),
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8)))),
                            child: const Text("Add To Cart"),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
