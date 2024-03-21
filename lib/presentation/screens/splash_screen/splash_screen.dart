import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:leafapp/presentation/screens/get_started/getStarted_screen.dart';
import 'package:leafapp/presentation/screens/login/login_screen.dart';
import 'package:leafapp/presentation/utils/shared_preferences.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Prefernces _prefs;
  bool _prefsInitialized = false;

  @override
  void initState() {
    super.initState();
    initializePrefs();
  }

  void initializePrefs() async {
    _prefs = Prefernces();
    await _prefs.initializeSharedPrefernces();
    setState(() {
      _prefsInitialized = true;
    });
  }

  Widget _handleNextScreen() {
    if (_prefsInitialized) {
      if (_prefs.getIntroStatus()) {
        return LoginPage();
      } else {
        return GetStarted();
      }
    } else {
      return Center(
        child: CircularProgressIndicator(
          color: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(child: Text("Logo")),
      nextScreen: _handleNextScreen(),
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.rightToLeft,
    );
  }
}
