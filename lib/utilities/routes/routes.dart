import 'package:flutter/material.dart';
import 'package:mvvm_project/utilities/routes/routes_names.dart';
import 'package:mvvm_project/view/home_screen.dart';
import 'package:mvvm_project/view/login_screen.dart';
import 'package:mvvm_project/view/sign_up.dart';
import 'package:mvvm_project/view/splash_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashView());
      //login route defined
      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen());
      //Home route defined
      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());

      case RoutesName.signUp:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SignUpScreen());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}
