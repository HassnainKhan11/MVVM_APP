import 'package:flutter/material.dart';
import 'package:mvvm_project/resources/components/rounded_button.dart';
import 'package:mvvm_project/utilities/routes/routes_names.dart';
import 'package:mvvm_project/viewModel/auth_view_model.dart';
import 'package:provider/provider.dart';

import '../utilities/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  final ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    _obsecurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height * 1;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Login into your account',
              style: TextStyle(color: Colors.black, fontSize: 24),
            ),
            const SizedBox(
              height: 32,
            ),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              focusNode: emailFocusNode,
              onFieldSubmitted: (value) {
                Utils.fieldFocusChange(
                    context, emailFocusNode, passwordFocusNode);
              },
              decoration: const InputDecoration(
                hintText: 'Email Address',
                labelText: 'Email',
                prefixIcon: Icon(Icons.email_outlined),
                prefixIconColor: Colors.blue,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ValueListenableBuilder(
              valueListenable: _obsecurePassword,
              builder: (BuildContext context, dynamic value, Widget? child) {
                return TextFormField(
                  controller: _passwordController,
                  focusNode: passwordFocusNode,
                  obscureText: _obsecurePassword.value,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                    hintText: 'Password',
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline_rounded),
                    prefixIconColor: Colors.blue,
                    suffixIcon: InkWell(
                      onTap: () {
                        _obsecurePassword.value = !_obsecurePassword.value;
                      },
                      child: _obsecurePassword.value
                          ? const Icon(Icons.visibility_outlined)
                          : const Icon(Icons.visibility_off_outlined),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 16,
            ),
            RoundButton(
              title: 'Login',
              loading: authViewModel.loading,
              onPress: () {
                if (_emailController.text.isEmpty) {
                  Utils.flushBarErrorMessage('Enter your email', context);
                } else if (_passwordController.text.isEmpty) {
                  Utils.flushBarErrorMessage('Enter your password', context);
                } else if (_passwordController.text.length < 6) {
                  Utils.flushBarErrorMessage(
                      'Weak password, make it stronger', context);
                } else {
                  Map data = {
                    'email': _emailController.text,
                    'password': _passwordController.text,
                  };
                  authViewModel.loginApi(data, context);
                  // print('API HIT');
                }
              },
            ),
            SizedBox(
              height: height * 0.02,
            ),
            InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.signUp);
                },
                child: const Text("Don't have an account? Sign up"))
          ],
        ),
      )),
    );
  }
}
