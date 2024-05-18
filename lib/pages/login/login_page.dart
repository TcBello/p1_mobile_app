import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:p1_mobile_app/utils/validator_util.dart';
import 'package:p1_mobile_app/view-model/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late GlobalKey<FormState> _formKey;

  late AuthProvider _authProvider;

  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  late ValueNotifier<bool> _isPasswordVisibleNotifier;

  final double _heightBetween = 8;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _authProvider = context.read<AuthProvider>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _isPasswordVisibleNotifier = ValueNotifier(false);
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _isPasswordVisibleNotifier.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      _authProvider
          .login(_emailController.text, _passwordController.text)
          .then((value) {
        if (value) {
          context.pushReplacementNamed('home');
        }
      });
    }
  }

  void _handleSignUp() {
    context.pushNamed('register');
  }

  void _handleChangePasswordVisibility(bool value) {
    _isPasswordVisibleNotifier.value = !value;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "MyStore",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 36),
              ),
              SizedBox(
                height: _heightBetween * 3,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email_rounded), hintText: "Email"),
                validator: ValidatorUtil.validateEmail,
              ),
              SizedBox(
                height: _heightBetween * 3,
              ),
              ValueListenableBuilder<bool>(
                  valueListenable: _isPasswordVisibleNotifier,
                  builder: (context, isPasswordVisible, child) {
                    return TextFormField(
                      obscureText: !isPasswordVisible,
                      controller: _passwordController,
                      validator: ValidatorUtil.validatePassword,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          hintText: "Password",
                          suffixIcon: IconButton(
                              onPressed: () => _handleChangePasswordVisibility(
                                  isPasswordVisible),
                              icon: Icon(isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off))),
                    );
                  }),
              SizedBox(
                height: _heightBetween * 5,
              ),
              SizedBox(
                height: 50,
                width: size.width * 0.8,
                child: TextButton(
                  onPressed: _handleLogin,
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.blue),
                      foregroundColor: MaterialStatePropertyAll(Colors.white)),
                  child: const Text("Sign in"),
                ),
              ),
              SizedBox(
                height: _heightBetween * 3,
              ),
              RichText(
                  text: TextSpan(
                      text: "Don't have an account?",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.black),
                      children: [
                    WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: TextButton(
                          onPressed: _handleSignUp,
                          style: const ButtonStyle(
                              foregroundColor:
                                  MaterialStatePropertyAll(Colors.blue)),
                          child: const Text("Sign up"),
                        ))
                  ]))
            ],
          ),
        ),
      ),
    );
  }
}
