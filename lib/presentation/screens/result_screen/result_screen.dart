import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:leafapp/data/models/leaf_model.dart';
import 'package:leafapp/logic/leaf/bloc/leaf_bloc.dart';
import 'package:share_plus/share_plus.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late LeafBloc _leafBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _leafBloc = BlocProvider.of(context);
  }

  void _handleShare(BuildContext context) {
    Share.share('check out my website');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Result"),
        actions: [
          InkWell(
            onTap: () {
              _handleShare(context);
            },
            child: Icon(
              Icons.share,
              color: Colors.green,
            ),
          ),
          Gap(10)
        ],
      ),
      body: BlocConsumer<LeafBloc, LeafState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is LeafPostedState) {
            LeafModel data = state.leafModel;
            return Center(
              child: Column(
                children: [
                  Text(data.className),
                  Text(data.confidence.toString())
                ],
              ),
            );
          } else {
            return Text("");
          }
        },
      ),
    );
  }
}
