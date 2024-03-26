import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:leafapp/presentation/utils/data.dart';

Widget shaderMask(context) {
  return Container(
    color: Colors.white,
    width: MediaQuery.of(context).size.width,
    child: ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          colors: [
            Color.fromARGB(255, 4, 159, 9),
            Color.fromARGB(190, 129, 233, 111),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ).createShader(bounds);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              logo,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "Discover the Hidden World of Leaves",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Gap(10),
          ],
        ),
      ),
    ),
  );
}
