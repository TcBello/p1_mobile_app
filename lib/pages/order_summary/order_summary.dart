import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:p1_mobile_app/model/entities/hive_cart_entity.dart';
import 'package:p1_mobile_app/pages/order_summary/components/order_summary_item.dart';

class OrderSummaryPage extends StatelessWidget {
  const OrderSummaryPage({super.key, required this.products});

  final List<HiveCartEntity> products;

  final double _heightBetween = 8;

  void _handleBack(BuildContext context) {
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    double totalPrice = 0;

    for (var item in products) {
      totalPrice += item.product.price * item.quantity;
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => _handleBack(context),
          icon: const Icon(Icons.close),
          style: const ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(Colors.white),
              backgroundColor: MaterialStatePropertyAll(Colors.blue)),
        ),
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              width: size.width,
              height: size.height * 0.3,
              color: Colors.grey.shade400,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Your order is on the way.",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(fontWeight: FontWeight.bold, fontSize: 32),
                  ),
                  SizedBox(
                    height: _heightBetween,
                  ),
                  Text(
                    "It will take 3-7 days.",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: 16),
                  ),
                  SizedBox(
                    height: _heightBetween,
                  ),
                  Text(
                    "You will be notified when the delivery is on its way to your address.",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: 16),
                  ),
                  SizedBox(
                    height: _heightBetween,
                  ),
                ],
              ),
            ),
            ...List.generate(
                products.length,
                (index) => OrderSummaryItem(
                      product: products[index].product,
                      quantity: products[index].quantity,
                    ))
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: size.width,
        height: 150,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                "Total:",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              trailing: Text(
                "\$${totalPrice.roundToDouble()}",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            SizedBox(
              height: _heightBetween,
            ),
            SizedBox(
              width: size.width * 0.8,
              height: 50,
              child: TextButton(
                onPressed: () => _handleBack(context),
                style: ButtonStyle(
                    foregroundColor:
                        const MaterialStatePropertyAll(Colors.white),
                    backgroundColor:
                        const MaterialStatePropertyAll(Colors.blue),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)))),
                child: const Text("Ok, got it."),
              ),
            )
          ],
        ),
      ),
    );
  }
}
