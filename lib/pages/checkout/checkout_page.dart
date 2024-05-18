import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:p1_mobile_app/model/entities/hive_cart_entity.dart';
import 'package:p1_mobile_app/utils/toast_util.dart';
import 'package:tuple/tuple.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key, required this.products});

  final List<HiveCartEntity> products;

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late ValueNotifier<String?> _personNameNotifier;
  late ValueNotifier<String?> _addressNotifier;

  @override
  void initState() {
    _personNameNotifier = ValueNotifier(null);
    _addressNotifier = ValueNotifier(null);
    super.initState();
  }

  @override
  void dispose() {
    _personNameNotifier.dispose();
    _addressNotifier.dispose();
    super.dispose();
  }

  Future<void> _handleEditShippingAddress() async {
    var result = await context
        .pushNamed<Tuple2<String, String>>('edit-shipping-address');

    if (result != null) {
      _personNameNotifier.value = result.item1;
      _addressNotifier.value = result.item2;
    }
  }

  void _handlePlaceOrder() {
    if (_personNameNotifier.value != null && _addressNotifier.value != null) {
      context.pushReplacementNamed('order-summary', extra: widget.products);
    } else {
      ToastUtil.showLong("Fill out the shipping address");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Checkout",
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                "Payment",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const Card(
              child: ListTile(
                contentPadding: EdgeInsets.all(8),
                leading: Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),
                title: Text("Cash on Delivery"),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                "Shipping Address",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              trailing: TextButton(
                onPressed: _handleEditShippingAddress,
                style: const ButtonStyle(
                    foregroundColor: MaterialStatePropertyAll(Colors.blue)),
                child: const Text("Edit"),
              ),
            ),
            ValueListenableBuilder<String?>(
                valueListenable: _personNameNotifier,
                builder: (context, name, child) {
                  return Text(
                    name ?? "Name",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: 16),
                  );
                }),
            const SizedBox(
              height: 8,
            ),
            ValueListenableBuilder<String?>(
                valueListenable: _addressNotifier,
                builder: (context, address, child) {
                  return Text(
                    address ?? "Address",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: 16),
                  );
                }),
            const Spacer(
              flex: 1,
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 50,
                width: size.width * 0.8,
                child: TextButton(
                  onPressed: _handlePlaceOrder,
                  style: ButtonStyle(
                      foregroundColor:
                          const MaterialStatePropertyAll(Colors.white),
                      backgroundColor:
                          const MaterialStatePropertyAll(Colors.blue),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)))),
                  child: const Text("Place Order"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
