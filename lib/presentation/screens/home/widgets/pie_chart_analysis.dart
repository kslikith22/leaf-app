import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:gap/gap.dart';

class PieChartAnalysis extends StatefulWidget {
  const PieChartAnalysis({super.key});

  @override
  State<PieChartAnalysis> createState() => _PieChartAnalysisState();
}

class _PieChartAnalysisState extends State<PieChartAnalysis> {
  Map<String, double> dataMap = {
    "Flutter": 5,
    "React": 3,
    "Xamarin": 2,
    "Ionic": 2,
  };

  Map<String, double> appUsageData = {
    "Images uploaded": 20,
    "Diseases detected": 10,
    "Info Generated": 10,
    "Sharing results": 20
  };

  List<Color> colorList = [
    Colors.green,
    Colors.red,
    Colors.blue,
    Colors.yellow
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "App usage",
            style: GoogleFonts.lato(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Gap(30),
          PieChart(
            dataMap: appUsageData,
            animationDuration: Duration(
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
              legendTextStyle: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w500,
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
              showChartValuesOutside: false,
              decimalPlaces: 1,
            ),
          ),
        ],
      ),
    );
  }
}
