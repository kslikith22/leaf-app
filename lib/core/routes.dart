import 'package:flutter/material.dart';
import 'package:leafapp/presentation/screens/master_screen/master_home_screen.dart';
import 'package:leafapp/presentation/screens/result_screen/result_screen.dart';
import 'package:page_transition/page_transition.dart';

class Routes {
  static Route? onGenerateRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: MasterHomePage(),
        );
      case '/result':
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: ResultScreen(),
        );
      default:
        return null;
    }
  }
}
