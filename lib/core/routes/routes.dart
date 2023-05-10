import 'package:flutter/material.dart';
import 'package:roadside_assistance/features/presentation/pages/account/edit_profile_page.dart';
import 'package:roadside_assistance/features/presentation/pages/car/car_page.dart';
import 'package:roadside_assistance/features/presentation/pages/history/history_page.dart';
import 'package:roadside_assistance/features/presentation/pages/home/home_page.dart';
import 'package:roadside_assistance/features/presentation/pages/motorbike/motor_bike_page.dart';

import '../../features/presentation/pages/auth/login.dart';
import '../../features/presentation/pages/auth/register.dart';
import '../../features/presentation/pages/choose_service/choose_service.dart';
import '../../features/presentation/pages/splash/splash_page.dart';

enum Routes {
  splash,
  home,
  main,
  login,
  register,
  editProfile,
  car,
  chooseSerivce,
  motorbike,
  history,
}

class _Paths {
  static const String splash = '/';
  static const String home = '/Home';
  static const String main = '/Main';
  static const String login = '/Login';
  static const String register = '/Register';
  static const String editProfile = '/editProfile';
  static const String car = '/Car';
  static const String motorbike = '/Motorbike';
  static const String chooseSerivce = '/chooseSerivce';
  static const String orderHistoryPage = '/OrderHistoryPage';

  static const Map<Routes, String> _pathMap = {
    Routes.splash: _Paths.splash,
    Routes.home: _Paths.home,
    Routes.main: _Paths.main,
    Routes.login: _Paths.login,
    Routes.register: _Paths.register,
    Routes.editProfile: _Paths.editProfile,
    Routes.car: _Paths.car,
    Routes.motorbike: _Paths.motorbike,
    Routes.chooseSerivce: _Paths.chooseSerivce,
    Routes.history: _Paths.orderHistoryPage,
  };

  static String of(Routes route) => _pathMap[route] ?? splash;
}

class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Route onGenerateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case _Paths.car:
        return FadeRoute(page: const CarPage());
      case _Paths.motorbike:
        return FadeRoute(page: const MotorBikePage());
      case _Paths.login:
        return FadeRoute(page: const LoginPage());
      case _Paths.register:
        return FadeRoute(page: const RegisterPage());
      case _Paths.home:
        return FadeRoute(page: const HomePage());
      case _Paths.editProfile:
        return FadeRoute(page: const EditProfilePage());
      case _Paths.chooseSerivce:
        return FadeRoute(page: const ChooseServicePage());
      case _Paths.orderHistoryPage:
        return FadeRoute(page: const OrderHistoryPage());

      /* 
      case _Paths.login:
        return FadeRoute(page: LoginPage());
      case _Paths.detailTicket:
        return FadeRoute(
            page: DetailsTicket(
          ticket: arguments as Ticket,
        ));
      case _Paths.detailTicketDone:
        return FadeRoute(
            page: DetailsTicketDone(
          ticket: arguments as Ticket,
        ));
 */

      default:
        return FadeRoute(page: const SlashPage());
    }
  }

  static Future? push<T>(Routes route, [T? arguments]) =>
      state?.pushNamed(_Paths.of(route), arguments: arguments);

  static Future? replaceWith<T>(Routes route, [T? arguments]) =>
      state?.pushReplacementNamed(_Paths.of(route), arguments: arguments);

  static void pop() => state?.pop();

  static NavigatorState? get state => navigatorKey.currentState;
}

class FadeRoute extends PageRouteBuilder {
  final Widget page;
  FadeRoute({required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
