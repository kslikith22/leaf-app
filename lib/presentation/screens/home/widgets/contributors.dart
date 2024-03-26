import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget contributors(context) {
  return InkWell(
    onTap: () {
      Navigator.pushNamed(context, '/contributors');
    },
    child: Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color.fromARGB(255, 241, 239, 239),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Contributors",
            style: GoogleFonts.lato(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 15,
          ),
        ],
      ),
    ),
  );
}
