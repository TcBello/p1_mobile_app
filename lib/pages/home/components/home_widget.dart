import 'package:flutter/material.dart';
import 'package:p1_mobile_app/model/entities/product_entity.dart';
import 'package:p1_mobile_app/pages/home/components/product_item.dart';
import 'package:p1_mobile_app/view-model/product_provider.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final productProvider = context.read<ProductProvider>();

    return SizedBox(
      width: size.width,
      height: size.height,
      child: FutureBuilder<List<ProductEntity>?>(
          future: productProvider.fetchProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasData) {
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: snapshot.data?.length ?? 0,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return ProductItem(
                    product: snapshot.data![index],
                  );
                },
              );
            }

            return Container();
          }),
    );
  }
}
