import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 80,
      padding: EdgeInsets.all(0),
      width: screenWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            spreadRadius: 0.2,
            blurRadius: 1,
            color: Colors.green,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Lottie.asset(
            'assets/lottie/leaf_hanging.json',
            width: 100,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 40,
              left: 45,
            ),
            child: Row(
              children: [
                Text(
                  "Leaf Lens",
                  style: GoogleFonts.lobster(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  width: 100,
                ),
                Icon(Icons.notifications_none),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
