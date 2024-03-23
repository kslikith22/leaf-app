import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leafapp/data/models/ai_model.dart';
import 'package:leafapp/data/models/leaf_model.dart';
import 'package:leafapp/logic/ai/bloc/ai_bloc.dart';
import 'package:leafapp/presentation/utils/repeaters.dart';
import 'package:share_plus/share_plus.dart';

class LeafLoadedUi extends StatefulWidget {
  final LeafModel leafData;
  final XFile image;
  const LeafLoadedUi({super.key, required this.leafData, required this.image});

  @override
  State<LeafLoadedUi> createState() => _LeafLoadedUiState();
}

class _LeafLoadedUiState extends State<LeafLoadedUi> {
  late AIBloc _aiBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _aiBloc = BlocProvider.of(context);
    _aiBloc.add(GenerateData(className: widget.leafData.className));
  }

  DecoratedBox _leafPredictionResults({required LeafModel leafData}) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Leaf Prediction Results",
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gap(20),
            Row(
              children: [
                Text(
                  "Class Name : ",
                  style: GoogleFonts.lato(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  leafData.className,
                  style: GoogleFonts.lato(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Gap(10),
            Row(
              children: [
                Text(
                  "Confidence : ",
                  style: GoogleFonts.lato(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "${leafData.confidence.round()} %",
                  style: GoogleFonts.lato(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Gap(18),
            if (leafData.confidence > 90)
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 183, 115, 13),
                    Color.fromARGB(255, 235, 161, 42),
                  ]),
                ),
                child: Text(
                  "High Confidence! The leaf has been identified with over 90% certainty",
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            Gap(20),
          ],
        ),
      ),
    );
  }

  Center _imageView({required XFile image}) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        child: Image.file(
          File(image.path),
          width: 200,
          height: 200,
        ),
      ),
    );
  }

  void _handleShare(BuildContext context,
      {required LeafModel leafData, required AIModel aiData}) {
    Share.share(
        'Class Name : ${leafData.className} \n\n Confidence : ${leafData.confidence.round().toString()} "%" \n\n Disease Info : ${aiData.about} \n\n Prevention Measures : ${aiData.prevention} ');
  }

  Widget _shareResults(
      {context, required LeafModel leafData, required AIModel aiData}) {
    return SizedBox(
      child: DecoratedBox(
        decoration: BoxDecoration(color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Gap(20),
              Text(
                "Share your prediction result with friends and fellow nature enthusiasts to spread awareness about leaf identification.",
                style: GoogleFonts.lato(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
              Gap(5),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 87, 218, 95),
                          const Color.fromARGB(255, 61, 155, 64)
                        ],
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          _handleShare(context,
                              leafData: leafData, aiData: aiData);
                        },
                        child: Icon(
                          Icons.share,
                          size: 28,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Gap(10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _aboutDisease({required double screenWidth, required AIModel data}) {
    return Container(
      width: screenWidth,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(10),
          Text(
            "AI-Powered Insights",
            style: GoogleFonts.lato(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Gap(5),
          Text(
            "Learn more about the disease and how to safeguard against it.",
            style: GoogleFonts.lato(
              color: const Color.fromARGB(255, 121, 118, 118),
              fontSize: 14,
            ),
          ),
          Gap(20),
          SizedBox(
            width: screenWidth,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    const Color.fromARGB(255, 2, 88, 74),
                    Colors.teal,
                  ],
                ),
                color: Colors.teal,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(5),
                    Text(
                      'Understanding the Leaf Class',
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Gap(10),
                    Text(
                      data.about,
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Gap(20),
          SizedBox(
            width: screenWidth,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color.fromARGB(255, 5, 75, 182),
                    Color.fromARGB(255, 51, 155, 239)
                  ],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(5),
                    Text(
                      'Prevention Measures',
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Gap(10),
                    Text(
                      data.prevention,
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(50),
          _imageView(image: widget.image),
          Gap(20),
          _leafPredictionResults(leafData: widget.leafData),
          Gap(20),
          BlocConsumer<AIBloc, AIState>(
            listener: (context, state) {
              if (state is AIErrorState) {
                snackbar(context, "Something went Wrong");
              }
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is AILoadingState) {
                return SizedBox(
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SpinKitChasingDots(
                        size: 28,
                        color: Colors.green,
                      ),
                      Gap(10),
                      Text(
                        "Generating Insights ...",
                        style: GoogleFonts.lato(
                          color: Color.fromARGB(255, 109, 107, 107),
                        ),
                      )
                    ],
                  ),
                );
              }
              if (state is AILoadedState) {
                return Column(
                  children: [
                    _aboutDisease(
                        screenWidth: screenWidth, data: state.aiModel),
                    Gap(20),
                    _shareResults(
                      context: context,
                      leafData: widget.leafData,
                      aiData: state.aiModel,
                    ),
                  ],
                );
              } else {
                return Text("");
              }
            },
          ),
          Gap(20),
        ],
      ),
    );
  }
}
