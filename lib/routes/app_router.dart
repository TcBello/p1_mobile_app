import 'package:go_router/go_router.dart';
import 'package:p1_mobile_app/model/entities/hive_cart_entity.dart';
import 'package:p1_mobile_app/model/entities/product_entity.dart';
import 'package:p1_mobile_app/pages/auth_wrapper.dart';
import 'package:p1_mobile_app/pages/checkout/checkout_page.dart';
import 'package:p1_mobile_app/pages/edit_shipping_address/edit_shipping_address_page.dart';
import 'package:p1_mobile_app/pages/home/home_page.dart';
import 'package:p1_mobile_app/pages/login/login_page.dart';
import 'package:p1_mobile_app/pages/order_summary/order_summary.dart';
import 'package:p1_mobile_app/pages/product_detail/product_detail_page.dart';
import 'package:p1_mobile_app/pages/register/register_page.dart';

class AppRouter {
  static GoRouter routes = GoRouter(routes: [
    GoRoute(
        name: '/',
        path: '/',
        builder: (context, state) => const AuthWrapper(),
        // redirect: (context, state) {
        //   final _authRepo = AuthRepository();
        //   bool isFirstLoad = true;

        //   if (_authRepo.isLoggedIn() && isFirstLoad) {
        //     return '/home';
        //   } else {
        //     isFirstLoad = false;
        //     return '/login';
        //   }
        // },
        routes: [
          GoRoute(
            name: 'login',
            path: 'login',
            builder: (context, state) => const LoginPage(),
          ),
          GoRoute(
            name: 'register',
            path: 'register',
            builder: (context, state) => const RegisterPage(),
          ),
          GoRoute(
            name: 'home',
            path: 'home',
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            name: 'product-detail',
            path: 'product-detail',
            builder: (context, state) {
              ProductEntity product = state.extra as ProductEntity;

              return ProductDetailPage(
                product: product,
              );
            },
          ),
          GoRoute(
            name: 'checkout',
            path: 'checkout',
            builder: (context, state) {
              final products = state.extra as List<HiveCartEntity>;

              return CheckoutPage(
                products: products,
              );
            },
          ),
          GoRoute(
            name: 'order-summary',
            path: 'order-summary',
            builder: (context, state) {
              final products = state.extra as List<HiveCartEntity>;

              return OrderSummaryPage(
                products: products,
              );
            },
          ),
          GoRoute(
            name: 'edit-shipping-address',
            path: 'edit-shipping-address',
            builder: (context, state) => const EditShippingAddressPage(),
          ),
        ])
  ]);
}
