import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leafapp/logic/auth/bloc/auth_bloc.dart';
import 'package:leafapp/presentation/utils/data.dart';
import 'package:leafapp/presentation/utils/shared_preferences.dart';
import 'package:loading_overlay/loading_overlay.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

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
        Navigator.pushReplacementNamed(context, '/get-started');
      }
    }
  }

  void _validateUser() {
    if (_prefsInitialized) {
      String token = _prefs.getToken();
      if (token.isNotEmpty) {
        _authBloc.add(UserVerifyEvent(token: token));
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.green, toolbarHeight: 0),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoginRequestSuccess) {
            Navigator.pushReplacementNamed(context, '/home');
            (context, '/home');
          } else if (state is AuthLoginError) {
            Navigator.pushReplacementNamed(context, '/login');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Session expired Please login again"),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoadingState) {
            return LoadingOverlay(
              isLoading: true,
              color: Colors.white,
              child: Container(
                width: screenWidth,
                height: screenHeight,
                decoration: const BoxDecoration(color: Colors.green),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      logo,
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Nature's Palette: Dive into Leaf Identification.",
                      style: GoogleFonts.lobster(
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: FontWeight.w200,
                      ),
                    )
                  ],
                )),
              ),
            );
          }
          return Container(
            width: screenWidth,
            height: screenHeight,
            decoration: const BoxDecoration(color: Colors.green),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    logo,
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Nature's Palette: Dive into Leaf Identification.",
                    style: GoogleFonts.lobster(
                      fontSize: 13,
                      color: Colors.white,
                      fontWeight: FontWeight.w200,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
