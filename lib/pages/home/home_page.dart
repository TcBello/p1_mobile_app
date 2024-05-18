import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:p1_mobile_app/pages/cart/cart_page.dart';
import 'package:p1_mobile_app/pages/home/components/home_widget.dart';
import 'package:p1_mobile_app/themes/app_colors.dart';
import 'package:p1_mobile_app/view-model/auth_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AuthProvider _authProvider;

  int _pageIndex = 0;

  final List<Widget> _pageFragments = [const HomeWidget(), const CartPage()];

  @override
  void initState() {
    _authProvider = context.read<AuthProvider>();
    super.initState();
  }

  void _handleChangePage(int value) {
    setState(() {
      _pageIndex = value;
    });
  }

  void _handleLogout() {
    _authProvider.logout().then((value) {
      if (value) {
        context.pushReplacementNamed('login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          "MyStore",
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          PopupMenuButton(
            icon: const CircleAvatar(
              child: Icon(Icons.person),
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: _handleLogout,
                child: const Text("Logout"),
              )
            ],
          )
        ],
      ),
      body: _pageFragments[_pageIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _pageIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: _handleChangePage,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: "Cart")
          ]),
    );
  }
}
