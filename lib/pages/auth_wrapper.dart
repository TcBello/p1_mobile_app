import 'package:flutter/material.dart';
import 'package:p1_mobile_app/pages/home/home_page.dart';
import 'package:p1_mobile_app/pages/login/login_page.dart';
import 'package:p1_mobile_app/view-model/auth_provider.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQuery.sizeOf(context);
    final authProvider = context.read<AuthProvider>();

    if (authProvider.isLoggedIn()) {
      return const HomePage();
    }

    return const LoginPage();
  }
}
