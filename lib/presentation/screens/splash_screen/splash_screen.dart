import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leafapp/logic/auth/bloc/auth_bloc.dart';
import 'package:leafapp/presentation/screens/get_started/getStarted_screen.dart';
import 'package:leafapp/presentation/screens/home/home_screen.dart';
import 'package:leafapp/presentation/screens/login/login_screen.dart';
import 'package:leafapp/presentation/utils/repeaters.dart';
import 'package:leafapp/presentation/utils/shared_preferences.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// todo : verify user with prefs token

class _SplashScreenState extends State<SplashScreen> {
  late Prefernces _prefs;
  bool _prefsInitialized = false;
  late AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    initializePrefs();
    _authBloc = BlocProvider.of(context);
  }

  void initializePrefs() async {
    _prefs = Prefernces();
    await _prefs.initializeSharedPrefernces();
    setState(() {
      _prefsInitialized = true;
    });
    if (_prefsInitialized) {
      if (_prefs.getIntroStatus()) {
        _validateUser();
      } else {
        Navigator.pushNamed(context, '/get-started');
      }
    }
  }

  void _validateUser() {
    if (_prefsInitialized) {
      String token = _prefs.getToken();
      if (token.isNotEmpty) {
        _authBloc.add(UserVerifyEvent(token: token));
      } else {
        Navigator.pushNamed(context, '/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoginRequestSuccess) {
          Navigator.pushNamed(context, '/home');
        } else if (state is AuthLoginError) {
          Navigator.pushNamed(context, '/login');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Session expired Please login again"),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is AuthLoadingState) {
          return Container(
            width: screenWidth,
            height: screenHeight,
            decoration: BoxDecoration(color: Colors.green),
            child: Center(child: Text("Logo")),
          );
        }
        return Container(
          width: screenWidth,
          height: screenHeight,
          decoration: BoxDecoration(color: Colors.green),
          child: Center(child: Text("Logo")),
        );
      },
    );
  }
}
