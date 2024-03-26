import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leafapp/data/models/user_activity_model.dart';
import 'package:leafapp/logic/user_activity/bloc/user_activity_bloc.dart';
import 'package:leafapp/presentation/utils/repeaters.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:gap/gap.dart';

class PieChartAnalysis extends StatefulWidget {
  const PieChartAnalysis({super.key});

  @override
  State<PieChartAnalysis> createState() => _PieChartAnalysisState();
}

class _PieChartAnalysisState extends State<PieChartAnalysis> {
  List<Color> colorList = [
    Colors.green,
    Colors.red,
    Colors.blue,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserActivityBloc, UserActivityState>(
      listener: (context, state) {
        if (state is UserActivityError) {
          snackbar(context, "Error Fetching Activity");
        }
      },
      builder: (context, state) {
        if (state is UserActivityLoadingState) {
          return Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            height: 300,
            child: Center(
              child: Column(
                children: [
                  const Gap(30),
                  const SpinKitCircle(
                    color: Colors.green,
                  ),
                  const Gap(10),
                  Text(
                    "Please wait...",
                    style: GoogleFonts.lato(
                      color: Colors.grey[700],
                    ),
                  )
                ],
              ),
            ),
          );
        }
        if (state is UserActivityLoadedState) {
          PieChartCountModel chartCountModel =
              state.userActivityModel.pieChartCountModel;
          if (chartCountModel.classNameCount == 0) {
            return Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Center(
                child: Text(
                  "No Insight data found ! Come back later",
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
            );
          } else {
            return Container(
              height: 300,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Analysis of App Usage",
                    style: GoogleFonts.lato(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(30),
                  PieChart(
                    dataMap: {
                      "Images Uploaded":
                          chartCountModel.imageUrlCount.toDouble(),
                      "Diseases Detected":
                          chartCountModel.classNameCount.toDouble(),
                      "Insights": chartCountModel.aboutCount.toDouble()
                    },
                    animationDuration: const Duration(
                      milliseconds: 800,
                    ),
                    chartLegendSpacing: 32,
                    chartRadius: MediaQuery.of(context).size.width / 3.2,
                    colorList: colorList,
                    initialAngleInDegree: 0,
                    chartType: ChartType.ring,
                    ringStrokeWidth: 32,
                    legendOptions: LegendOptions(
                      showLegendsInRow: false,
                      legendPosition: LegendPosition.right,
                      showLegends: true,
                      legendShape: BoxShape.circle,
                      legendTextStyle: GoogleFonts.lato(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    chartValuesOptions: ChartValuesOptions(
                      showChartValueBackground: true,
                      chartValueStyle: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                      showChartValues: true,
                      showChartValuesInPercentage: false,
                      showChartValuesOutside: true,
                      decimalPlaces: 0,
                    ),
                  ),
                  const Gap(20),
                  Text(
                    "Here's a breakdown of insights proportions. Each slice represents a percentage of the whole.",
                    style: GoogleFonts.lato(color: Colors.grey, fontSize: 12),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            );
          }
        } else {
          return const Text("");
        }
      },
    );
  }
}
