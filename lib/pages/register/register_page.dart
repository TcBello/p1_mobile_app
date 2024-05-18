import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:p1_mobile_app/utils/validator_util.dart';
import 'package:p1_mobile_app/view-model/auth_provider.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late GlobalKey<FormState> _formKey;

  late AuthProvider _authProvider;

  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  late ValueNotifier<bool> _isPasswordVisibleNotifier;
  late ValueNotifier<bool> _isConfirmPasswordVisibleNotifier;

  final double _heightBetween = 8;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _authProvider = context.read<AuthProvider>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _isPasswordVisibleNotifier = ValueNotifier(false);
    _isConfirmPasswordVisibleNotifier = ValueNotifier(false);
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _isPasswordVisibleNotifier.dispose();
    _isConfirmPasswordVisibleNotifier.dispose();
    super.dispose();
  }

  void _handleSignIn() {
    context.pop();
  }

  void _handleSignUp() {
    if (_formKey.currentState!.validate()) {
      _authProvider
          .register(_emailController.text, _passwordController.text)
          .then((value) {
        if (value) {
          context.pop();
          context.pushReplacementNamed('home');
        }
      });
    }
  }

  void _handleChangePasswordVisibility(bool value) {
    _isPasswordVisibleNotifier.value = !value;
  }

  void _handleChangeConfirmPasswordVisibility(bool value) {
    _isConfirmPasswordVisibleNotifier.value = !value;
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
                "Sign Up",
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
                height: _heightBetween * 3,
              ),
              ValueListenableBuilder<bool>(
                  valueListenable: _isConfirmPasswordVisibleNotifier,
                  builder: (context, isConfirmPasswordVisible, child) {
                    return TextFormField(
                      obscureText: !isConfirmPasswordVisible,
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          hintText: "Confirm Password",
                          suffixIcon: IconButton(
                              onPressed: () =>
                                  _handleChangeConfirmPasswordVisibility(
                                      isConfirmPasswordVisible),
                              icon: Icon(isConfirmPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off))),
                      validator: (value) =>
                          ValidatorUtil.validateConfirmPassword(
                              value, _passwordController.text),
                    );
                  }),
              SizedBox(
                height: _heightBetween * 5,
              ),
              SizedBox(
                height: 50,
                width: size.width * 0.8,
                child: TextButton(
                  onPressed: _handleSignUp,
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.blue),
                      foregroundColor: MaterialStatePropertyAll(Colors.white)),
                  child: const Text("Sign up"),
                ),
              ),
              SizedBox(
                height: _heightBetween * 3,
              ),
              RichText(
                  text: TextSpan(
                      text: "Already have an account?",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.black),
                      children: [
                    WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: TextButton(
                          onPressed: _handleSignIn,
                          style: const ButtonStyle(
                              foregroundColor:
                                  MaterialStatePropertyAll(Colors.blue)),
                          child: const Text("Sign in"),
                        ))
                  ]))
            ],
          ),
        ),
      ),
    );
  }
}
