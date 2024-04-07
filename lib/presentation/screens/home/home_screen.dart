import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leafapp/data/models/user_model.dart';
import 'package:leafapp/logic/auth/bloc/auth_bloc.dart';
import 'package:leafapp/logic/user_activity/bloc/user_activity_bloc.dart';
import 'package:leafapp/presentation/screens/home/widgets/carousel.dart';
import 'package:leafapp/presentation/screens/home/widgets/contributors.dart';
import 'package:leafapp/presentation/screens/home/widgets/heading_shadermask.dart';
import 'package:leafapp/presentation/screens/home/widgets/pie_chart_analysis.dart';
import 'package:leafapp/presentation/screens/home/widgets/user_history.dart';
import 'package:leafapp/presentation/utils/data.dart';
import 'package:leafapp/presentation/utils/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Prefernces _prefs;
  late int _tabBarViewIndex = 0;
  late AuthBloc _authBloc;
  late UserActivityBloc _userActivityBloc;

  @override
  void initState() {
    super.initState();
    initializePreferences();
    _userActivityBloc = BlocProvider.of<UserActivityBloc>(context);
    _userActivityBloc.add(FetchUserActivity());
  }

  void initializePreferences() async {
    _prefs = Prefernces();
    await _prefs.initializeSharedPrefernces();
    _authBloc = BlocProvider.of(context);
  }

  final List _tabBarScreens = [
    const PieChartAnalysis(),
    const UserHistory(),
  ];

  void _handleLogout() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          surfaceTintColor: Colors.white,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Are You Sure ?",
                style: GoogleFonts.roboto(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Gap(2),
              Text(
                "You will logged out from the current session !",
                style: GoogleFonts.lato(fontSize: 10, color: Colors.grey),
              ),
            ],
          ),
          actions: [
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        gradient: LinearGradient(colors: [
                          Color.fromARGB(255, 63, 176, 69),
                          Colors.green
                        ])),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "No, I Want to stay",
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const Gap(15),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      border: Border.all(
                        color: Colors.green,
                        width: 2,
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        _authBloc.add(UserLogoutEvent());
                        _prefs.removeToken();
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/login',
                          ((route) => false),
                        );
                      },
                      child: Text(
                        "Yes, Logout !",
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  Container customTabBar() {
    return Container(
      padding: const EdgeInsets.only(top: 40, bottom: 10),
      decoration: const BoxDecoration(
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
                border: const Border(
                  left: BorderSide(color: Colors.green, width: 1.0),
                  top: BorderSide(color: Colors.green, width: 1.0),
                  bottom: BorderSide(color: Colors.green, width: 1.0),
                ),
                borderRadius: const BorderRadius.only(
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
                  setState(
                    () {
                      _tabBarViewIndex = 0;
                    },
                  );
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
                border: const Border(
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
                borderRadius: const BorderRadius.only(
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
                  setState(
                    () {
                      _tabBarViewIndex = 1;
                    },
                  );
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
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoginRequestSuccess) {
          AuthResponse userData = state.authResponse;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              title: Row(
                children: [
                  Text(
                    logo,
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const Gap(8),
                  Image.asset(
                    'assets/images/logo.png',
                    width: 23,
                  ),
                ],
              ),
              actions: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  child: userData.user.profilePicture.isNotEmpty
                      ? Image.network(
                          userData.user.profilePicture,
                          width: 30,
                          height: 30,
                        )
                      : Image.asset(
                          'assets/images/profile.png',
                          width: 33,
                          height: 33,
                        ),
                ),
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {
                    _handleLogout();
                  },
                  child: const Icon(
                    Icons.logout,
                    size: 25,
                  ),
                )
              ],
            ),
            backgroundColor: Colors.green[50],
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      shaderMask(context),
                      const Carousel(),
                      customTabBar(),
                      _tabBarScreens[_tabBarViewIndex],
                      const Gap(30),
                      if (_tabBarViewIndex == 0) contributors(context),
                      const Gap(50),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else {
          // never occurs
          return const Text("");
        }
      },
    );
  }
}
