import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:leafapp/logic/auth/bloc/auth_bloc.dart';
import 'package:leafapp/presentation/screens/home/home_screen.dart';
import 'package:leafapp/presentation/screens/master_screen/master_home_screen.dart';
import 'package:leafapp/presentation/utils/repeaters.dart';
import 'package:leafapp/presentation/utils/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sign_in_button/sign_in_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Prefernces _prefs;
  late GoogleSignIn _googleSignIn;
  late AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _prefs = Prefernces();
    initializePrefernces();
    _googleSignIn = GoogleSignIn(scopes: ['email']);
    _authBloc = BlocProvider.of<AuthBloc>(context);
  }

  void initializePrefernces() async {
    await _prefs.initializeSharedPrefernces();
  }

  void _handleSignIn() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        _authBloc.add(
          UserLoginEvent(
              email: googleSignInAccount.email,
              name: googleSignInAccount.displayName!,
              profilePicture: googleSignInAccount.photoUrl!,
              status: '',
              token: ''),
        );
        print('User: ${googleSignInAccount.displayName}');
      } else {
        print('Sign in canceled');
      }
    } catch (error) {
      print('Error signing in: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: screenHeight * 0.5,
            width: screenWidth,
            decoration: const BoxDecoration(color: Colors.green),
            child: Stack(
              children: [
                Center(
                  child: SvgPicture.asset(
                    'assets/svg/undraw_festivities_tvvj.svg',
                    width: 200,
                    height: 200,
                  ),
                ),
                Positioned(
                  child: Text(
                    "Logo Logo",
                    style: GoogleFonts.lobster(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  top: 50,
                  right: screenWidth * 0.40,
                )
              ],
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Container(
              width: screenWidth,
              height: screenHeight * 0.5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(20),
                  right: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Login",
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthLoginRequestSuccess) {
                        _prefs.setToken(token: state.authResponse.token);
                        Navigator.pushReplacementNamed(context, '/home');
                      }
                      if (state is AuthLoginError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Something went wrong"),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthLoadingState) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Center(
                              child: SignInButton(
                                Buttons.google,
                                text: "Sign in with google",
                                onPressed: () {
                                  _handleSignIn();
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
