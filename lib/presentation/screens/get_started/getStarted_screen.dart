import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:leafapp/presentation/screens/home/widgets/custom_appbar.dart';
import 'package:leafapp/presentation/screens/login/login_screen.dart';
import 'package:leafapp/presentation/screens/master_screen/master_home_screen.dart';
import 'package:leafapp/presentation/utils/constants.dart';
import 'package:leafapp/presentation/utils/data.dart';
import 'package:leafapp/presentation/utils/repeaters.dart';
import 'package:leafapp/presentation/utils/shared_preferences.dart';
import 'package:lottie/lottie.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  late Prefernces _prefs;

  @override
  void initState() {
    super.initState();
    _prefs = Prefernces();
    initializePreferences();
  }

  Future initializePreferences() async {
    await _prefs.initializeSharedPrefernces();
  }

  void _handlelogin() {
    _prefs.setIntroStatus(value: true);
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: Lottie.asset(
              'assets/lottie/leaf_hanging.json',
              height: 200,
            ),
          ),
          Expanded(
            child: Center(
              child: SizedBox(
                width: screenWidth * 1,
                height: screenHeight * 0.6,
                child: IntroductionScreen(
                  pages: pageViewData.map((e) {
                    return PageViewModel(
                      titleWidget: Text(
                        e['title'],
                        style: GoogleFonts.lato(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      bodyWidget: Center(
                        child: Text(
                          e['body'],
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }).toList(),
                  done: InkWell(
                    onTap: () => _handlelogin(),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 117, 200, 119),
                            Color.fromARGB(255, 54, 138, 56)
                          ],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                        ),
                      ),
                      child: Text(
                        "Get Started",
                        style: GoogleFonts.lato(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  onDone: () => LoginPage(),
                  dotsDecorator: DotsDecorator(
                    activeColor: Colors.green,
                    activeSize: const Size(20.0, 10.0),
                    spacing: const EdgeInsets.symmetric(horizontal: 5.0),
                    activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  next: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 117, 200, 119),
                          Color.fromARGB(255, 54, 138, 56)
                        ],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
                    ),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
