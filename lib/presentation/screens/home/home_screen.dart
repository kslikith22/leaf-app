import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leafapp/presentation/screens/home/widgets/carousel.dart';
import 'package:leafapp/presentation/screens/home/widgets/custom_appbar.dart';
import 'package:leafapp/presentation/screens/home/widgets/heading_shadermask.dart';
import 'package:leafapp/presentation/screens/home/widgets/pie_chart_analysis.dart';
import 'package:leafapp/presentation/screens/home/widgets/user_history.dart';
import 'package:leafapp/presentation/utils/shared_preferences.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Prefernces _prefs;
  late int _tabBarViewIndex = 0;

  @override
  void initState() {
    super.initState();
    initializePreferences();
  }

  void initializePreferences() async {
    _prefs = Prefernces();
    await _prefs.initializeSharedPrefernces();
  }

  List _tabBarScreens = [
    PieChartAnalysis(),
    UserHistory(),
  ];

  Container customTabBar() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
            width: 100,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: _tabBarViewIndex == 0 ? Colors.green : Colors.white,
                border: Border(
                  left: BorderSide(color: Colors.green, width: 1.0),
                  top: BorderSide(color: Colors.green, width: 1.0),
                  bottom: BorderSide(color: Colors.green, width: 1.0),
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                ),
              ),
              child: TextButton(
                child: Text(
                  "Usage",
                  style: GoogleFonts.lato(
                    color: _tabBarViewIndex == 0 ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _tabBarViewIndex = 0;
                  });
                },
              ),
            ),
          ),
          SizedBox(
            height: 40,
            width: 100,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: _tabBarViewIndex == 1 ? Colors.green : Colors.white,
                border: Border(
                  right: BorderSide(
                    color: Colors.green,
                    width: 1.0,
                  ),
                  top: BorderSide(
                    color: Colors.green,
                    width: 1.0,
                  ),
                  bottom: BorderSide(
                    color: Colors.green,
                    width: 1.0,
                  ),
                ),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
              ),
              child: TextButton(
                child: Text(
                  "History",
                  style: GoogleFonts.lato(
                    color: _tabBarViewIndex == 1 ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _tabBarViewIndex = 1;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppbar(),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                children: [
                  shaderMask(),
                  const Carousel(),
                  customTabBar(),
                  _tabBarScreens[_tabBarViewIndex]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
