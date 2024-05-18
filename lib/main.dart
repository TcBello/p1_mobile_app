import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:p1_mobile_app/model/entities/hive_cart_entity.dart';
import 'package:p1_mobile_app/model/entities/hive_user_entity.dart';
import 'package:p1_mobile_app/model/entities/product_entity.dart';
import 'package:p1_mobile_app/model/entities/rating_entity.dart';
import 'package:p1_mobile_app/routes/app_router.dart';
import 'package:p1_mobile_app/utils/is_logged_in_util.dart';
import 'package:p1_mobile_app/view-model/auth_provider.dart';
import 'package:p1_mobile_app/view-model/cart_provider.dart';
import 'package:p1_mobile_app/view-model/product_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(HiveUserEntityAdapter());
  Hive.registerAdapter(ProductEntityAdapter());
  Hive.registerAdapter(RatingEntityAdapter());
  Hive.registerAdapter(HiveCartEntityAdapter());
  await HiveUserEntity.openBox();
  await HiveCartEntity.openBox();
  await IsLoggedInUtil.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider())
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.routes,
      ),
    );
  }
}
