import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leafapp/data/models/leaf_model.dart';
import 'package:leafapp/logic/leaf/bloc/leaf_bloc.dart';
import 'package:leafapp/presentation/screens/result_screen/widgets/leaf_loaded_ui.dart';
import 'package:share_plus/share_plus.dart';

class ResultScreen extends StatefulWidget {
  final XFile image;
  const ResultScreen({super.key, required this.image});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        leadingWidth: 40,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.green,
            ),
          ),
        ),
        title: Text(
          "Outcome",
          style: GoogleFonts.lato(),
        ),
      ),
      body: BlocConsumer<LeafBloc, LeafState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is LeafPostedState) {
            LeafModel data = state.leafModel;
            return LeafLoadedUi(leafData: data, image: widget.image);
          } else {
            return const Text("");
          }
        },
      ),
    );
  }
}
