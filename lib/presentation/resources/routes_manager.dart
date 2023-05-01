import 'package:flutter/material.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/presentation/forget_password/forget_password_view.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/presentation/login/view/login_view.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/presentation/main/main_view.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/presentation/onboarding/view/onboarding_view.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/presentation/register/register_view.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/presentation/resources/strings_manager.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/presentation/splash/splash_view.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/presentation/store_details/store_details_view.dart';

class Routes {
  static const String splashRoute = '/';
  static const String onBoardingRoute = '/onBoarding';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String forgetPasswordRoute = '/forgetPassword';
  static const String mainRoute = '/main';
  static const String storeDetailsRoute = '/storeDetails';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.forgetPasswordRoute:
        return MaterialPageRoute(
            builder: (context) => const ForgetPasswordView());
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.storeDetailsRoute:
        return MaterialPageRoute(builder: (_) => const StoreDetailsView());
      default:
        return _undefinedRoute();
    }
  }

  static Route<dynamic> _undefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.noRouteFound),
        ),
        body: const Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}
