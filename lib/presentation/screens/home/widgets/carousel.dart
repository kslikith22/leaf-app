import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leafapp/presentation/utils/data.dart';

class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  late int carouselIndex;
  @override
  void initState() {
    super.initState();
    carouselIndex = 0;
  }

  void handleCarouselChange(int index) {
    setState(() {
      carouselIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         const Gap(14),
          Text(
            "Common Plant Diseases",
            style: GoogleFonts.lato(
              fontSize: 17,
              color: Colors.grey[800],
              fontWeight: FontWeight.bold,
            ),
          ),
          CarouselSlider(
            options: CarouselOptions(
              height: 240,
              aspectRatio: 16 / 9,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              // autoPlayInterval: const Duration(seconds: 10),
              // autoPlayAnimationDuration: const Duration(seconds: 3),
              // autoPlayCurve: Curves.bounceOut,
              enlargeCenterPage: true,
              enlargeFactor: 0.2,
              onPageChanged: (index, reason) => handleCarouselChange(index),
              scrollDirection: Axis.horizontal,
            ),
            items: carouselItems.map(
              (index) {
                return Builder(
                  builder: (context) {
                    return Container(
                      width: screenWidth,
                      margin: const EdgeInsets.only(left: 2, right: 2, top: 20),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Image.asset(
                              index['image'],
                            ),
                          ),
                          Positioned(
                            top: 10,
                            left: 0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding:const EdgeInsets.only(
                                    left: 10,
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  height: 200,
                                  color: Colors.transparent,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        index['imgHeading'],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.8,
                                        child: Text(
                                          index['imgTitle'],
                                          style: GoogleFonts.lato(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 58,
                                      ),
                                      const SizedBox(height: 20)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}
