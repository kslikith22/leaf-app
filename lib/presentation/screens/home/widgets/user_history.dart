import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leafapp/data/models/user_activity_model.dart';
import 'package:leafapp/logic/user_activity/bloc/user_activity_bloc.dart';
import 'package:leafapp/presentation/utils/repeaters.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

class UserHistory extends StatefulWidget {
  const UserHistory({super.key});

  @override
  State<UserHistory> createState() => _UserHistoryState();
}

class _UserHistoryState extends State<UserHistory> {
  void _handleShare(BuildContext context,
      {required UserHistoryModel historyData}) {
    Share.share(
        'Class Name : ${historyData.className}\n\nConfidence : ${historyData.confidence.round().toString()}%\n\nDisease Info : ${historyData.about}\n\nPrevention Measures : ${historyData.prevention} ');
  }

  Widget _shareResultsUI({context, required UserHistoryModel data}) {
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
                      color: Colors.green,
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          _handleShare(context, historyData: data);
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

  void _handleMoreInfo({context, required UserHistoryModel history}) {
    showBottomSheet(
      context: context,
      builder: (_) {
        return BottomSheet(
          enableDrag: false,
          showDragHandle: false,
          onClosing: () {},
          builder: (context) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                decoration: const BoxDecoration(color: Colors.white),
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(10),
                    Text(
                      history.className,
                      style: GoogleFonts.lato(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(10),
                    Text(
                      "Confidence : ${history.confidence.round()}",
                      style: GoogleFonts.lato(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                      ),
                    ),
                    const Gap(20),
                    Text(
                      "Preview",
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          history.imageUrl.startsWith('http://') ||
                                  history.imageUrl.startsWith('https://')
                              ? ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  child: Image.network(
                                    history.imageUrl,
                                    width: 260,
                                    height: 300,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const Text(""),
                          const Gap(20),
                          history.markedUrl.startsWith('http://') ||
                                  history.markedUrl.startsWith('https://')
                              ? ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  child: Image.network(
                                    history.markedUrl,
                                    width: 260,
                                    height: 300,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const Text(""),
                          const Gap(20),
                          history.heatmapUrl.startsWith('http://') ||
                                  history.heatmapUrl.startsWith('https://')
                              ? ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  child: Image.network(
                                    history.heatmapUrl,
                                    width: 260,
                                    height: 300,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const Text(""),
                        ],
                      ),
                    ),
                    const Gap(40),
                    DecoratedBox(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 16, 74, 161),
                            Color.fromARGB(255, 39, 129, 165)
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "About",
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const Gap(10),
                            Text(
                              history.about,
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(20),
                    DecoratedBox(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 27, 94, 32),
                            Colors.green,
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Measures",
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const Gap(10),
                            Text(
                              history.prevention,
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    _shareResultsUI(context: context, data: history)
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserActivityBloc, UserActivityState>(
      listener: (context, state) {
        if (state is UserActivityError) {
          snackbar(context, "Error fetching activities");
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
          UserActivityModel data = state.userActivityModel;
          if (data.userHistoryModel.isEmpty) {
            return Container(
              color: Colors.white,
              height: 150,
              child: Center(
                child: Text(
                  "No Saved Data found at the moment !",
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
            );
          } else {
            return Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.userHistoryModel.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      UserHistoryModel history = data.userHistoryModel[index];
                      return InkWell(
                        onLongPress: () {
                          snackbar(
                            context,
                            'Press More Info to know about ${history.className}',
                          );
                        },
                        onTap: () {
                          _handleMoreInfo(context: context, history: history);
                        },
                        child: Column(
                          children: [
                            ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      history.imageUrl.startsWith('http://') ||
                                              history.imageUrl
                                                  .startsWith('https://')
                                          ? ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              child: Image.network(
                                                history.imageUrl,
                                                width: 40,
                                                height: 40,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : Text(
                                              "Image not found",
                                              style: GoogleFonts.lato(
                                                  fontSize: 10),
                                            ),
                                      const Gap(20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            history.className,
                                            style: GoogleFonts.lato(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "confidence : ${history.confidence.round()}",
                                            style: GoogleFonts.lato(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                      ],
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "More Info >",
                                    style: GoogleFonts.lato(
                                      fontSize: 13,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.grey[300],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }
        } else if (state is UserActivityError) {
          return Text(state.error);
        }
        return const Text("");
      },
    );
  }
}
