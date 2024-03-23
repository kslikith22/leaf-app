import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:leafapp/logic/auth/bloc/auth_bloc.dart';
import 'package:leafapp/presentation/screens/home/home_screen.dart';
import 'package:leafapp/presentation/screens/master_screen/master_home_screen.dart';
import 'package:leafapp/presentation/utils/data.dart';
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

  void _showMisuseDialog() {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            surfaceTintColor: Colors.white,
            title: Text(
              "Secure Access Portal",
              style: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              "Protecting Your Privacy: Login to Ensure Secure and Authorized Access to Our Services. We utilize Google authentication to safeguard your account and prevent misuse. Your privacy and security are our top priorities.",
              style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Ok Understood !"),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                      logo,
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
                      height: 40,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Text(
                            "Welcome",
                            style: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              textAlign: TextAlign.center,
                              "We are just one step away from diving into world of leaves",
                              style: GoogleFonts.lato(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
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
                                  elevation: 5,
                                  padding: EdgeInsets.all(10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                  ),
                                  text: "Sign in with google",
                                  onPressed: () {
                                    _handleSignIn();
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              Text(
                                "This step is prevent misuse of service",
                                style: GoogleFonts.lato(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              InkWell(
                                onTap: () {
                                  _showMisuseDialog();
                                },
                                child: Text(
                                  "View More >",
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              )
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
      ),
    );
  }
}
