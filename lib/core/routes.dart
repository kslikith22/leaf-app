import 'package:flutter/material.dart';
import 'package:leafapp/presentation/screens/get_started/getStarted_screen.dart';
import 'package:leafapp/presentation/screens/login/login_screen.dart';
import 'package:leafapp/presentation/screens/master_screen/master_home_screen.dart';
import 'package:leafapp/presentation/screens/result_screen/result_screen.dart';
import 'package:page_transition/page_transition.dart';

class Routes {
  static Route? onGenerateRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/home':
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: MasterHomePage(),
        );
      case '/login':
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: LoginPage(),
        );
      case '/get-started':
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: GetStarted(),
        );
      case '/result':
        Map<String, dynamic> arguments =
            routeSettings.arguments as Map<String, dynamic>;
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: ResultScreen(
            image: arguments['image'],
          ),
        );
      default:
        return null;
    }
  }
}
