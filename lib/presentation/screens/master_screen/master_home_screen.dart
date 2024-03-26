import 'package:flutter/material.dart';
import 'package:leafapp/presentation/screens/home/home_screen.dart';
import 'package:leafapp/presentation/screens/scan/scan_screen.dart';

class MasterHomePage extends StatefulWidget {
  const MasterHomePage({super.key});

  @override
  State<MasterHomePage> createState() => _MasterHomePageState();
}

class _MasterHomePageState extends State<MasterHomePage> {
  int selectIndex = 0;

  List screens = [
    const HomePage(),
    const ScanScreen(),
  ];

  void handleChange(index) {
    setState(() {
      selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectIndex],
      bottomNavigationBar: BottomNavigationBar(
        enableFeedback: true,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        elevation: 10,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.green,
        selectedIconTheme: const IconThemeData(size: 25),
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: selectIndex == 0
                ? const Icon(Icons.home_filled)
                : const Icon(Icons.home_outlined),
          ),
          const BottomNavigationBarItem(
            label: "Scan",
            icon: Icon(Icons.qr_code_scanner),
          )
        ],
        onTap: (index) => handleChange(index),
        currentIndex: selectIndex,
      ),
    );
  }
}
