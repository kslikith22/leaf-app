import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leafapp/data/models/ai_model.dart';
import 'package:leafapp/data/models/leaf_model.dart';
import 'package:leafapp/logic/ai/bloc/ai_bloc.dart';
import 'package:leafapp/logic/user_activity/bloc/user_activity_bloc.dart';
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
  late UserActivityBloc _userActivityBloc;

  @override
  void initState() {
    super.initState();
    _aiBloc = BlocProvider.of<AIBloc>(context);
    _aiBloc.add(GenerateData(className: widget.leafData.className));
    _userActivityBloc = BlocProvider.of<UserActivityBloc>(context);
  }

  DecoratedBox _leafPredictionResults({required LeafModel leafData}) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              "Leaf Prediction Results",
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(20),
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
            const Gap(10),
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
            const Gap(18),
            if (leafData.confidence > 90)
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 183, 115, 13),
                      Color.fromARGB(255, 235, 161, 42),
                    ],
                  ),
                ),
                child: Text(
                  "High Confidence! The leaf has been identified with over 90% certainty",
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            const Gap(20),
          ],
        ),
      ),
    );
  }

  Widget _imageView({required LeafModel leafData}) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              const Gap(30),
              Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image.network(
                      leafData.imageUrl,
                      width: 260,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Gap(20),
                  Text(
                    "Uploaded Image",
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              const Gap(30),
              Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image.network(
                      leafData.markedUrl,
                      width: 260,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Gap(20),
                  Text(
                    "Marked image",
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Gap(30),
              Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image.network(
                      leafData.heatmapUrl,
                      width: 260,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Gap(20),
                  Text(
                    "Heatmap",
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleShare(BuildContext context,
      {required LeafModel leafData, required AIModel aiData}) {
    Share.share(
        'Class Name : ${leafData.className} \n\n Confidence : ${leafData.confidence.round().toString()} "%" \n\n Disease Info : ${aiData.about} \n\n Prevention Measures : ${aiData.prevention} ');
  }

  Widget _shareResultsUI(
      {context, required LeafModel leafData, required AIModel aiData}) {
    return SizedBox(
      child: DecoratedBox(
        decoration: const BoxDecoration(color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Gap(20),
              Text(
                "Share your prediction result with friends and fellow nature enthusiasts to spread awareness about leaf identification.",
                style: GoogleFonts.lato(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
              const Gap(5),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 87, 218, 95),
                          Color.fromARGB(255, 61, 155, 64)
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
                        child: const Icon(
                          Icons.share,
                          size: 28,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Gap(10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _aboutDisease({required double screenWidth, required AIModel data}) {
    return Container(
      width: screenWidth,
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(10),
          Text(
            "AI-Powered Insights",
            style: GoogleFonts.lato(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Gap(5),
          Text(
            "Learn more about the disease and how to safeguard against it.",
            style: GoogleFonts.lato(
              color: const Color.fromARGB(255, 121, 118, 118),
              fontSize: 14,
            ),
          ),
          const Gap(20),
          SizedBox(
            width: screenWidth,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color.fromARGB(255, 2, 88, 74),
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
                    const Gap(5),
                    Text(
                      'Understanding the Leaf Class',
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Gap(10),
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
          const Gap(20),
          SizedBox(
            width: screenWidth,
            child: DecoratedBox(
              decoration: const BoxDecoration(
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
                    const Gap(5),
                    Text(
                      'Prevention Measures',
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Gap(10),
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
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(50),
          _imageView(leafData: widget.leafData),
          const Gap(20),
          _leafPredictionResults(leafData: widget.leafData),
          const Gap(20),
          BlocConsumer<AIBloc, AIState>(
            listener: (context, state) {
              if (state is AIErrorState) {
                snackbar(context, "Something went Wrong");
              }
            },
            builder: (context, state) {
              if (state is AILoadingState) {
                return SizedBox(
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SpinKitChasingDots(
                        size: 28,
                        color: Colors.green,
                      ),
                      const Gap(10),
                      Text(
                        "Generating Insights ...",
                        style: GoogleFonts.lato(
                          color: const Color.fromARGB(255, 109, 107, 107),
                        ),
                      )
                    ],
                  ),
                );
              }
              if (state is AILoadedState) {
                _userActivityBloc.add(
                  UserActivityPostEvent(
                    aiModel: state.aiModel,
                    leafModel: widget.leafData,
                  ),
                );
                return BlocConsumer<UserActivityBloc, UserActivityState>(
                  listener: (context, activityState) {
                    if (activityState is UserActivityPostError) {
                      snackbar(context, "Error posting data");
                    }
                  },
                  builder: (context, activityState) {
                    if (activityState is UserActivityPostedState) {
                      return Column(
                        children: [
                          _aboutDisease(
                            screenWidth: screenWidth,
                            data: state.aiModel,
                          ),
                          const Gap(20),
                          _shareResultsUI(
                            context: context,
                            leafData: widget.leafData,
                            aiData: state.aiModel,
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          _aboutDisease(
                            screenWidth: screenWidth,
                            data: state.aiModel,
                          ),
                          const Gap(20),
                          _shareResultsUI(
                            context: context,
                            leafData: widget.leafData,
                            aiData: state.aiModel,
                          ),
                        ],
                      );
                    }
                  },
                );
              } else {
                return const Text("");
              }
            },
          ),
          const Gap(20),
        ],
      ),
    );
  }
}
