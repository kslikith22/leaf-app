import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:leafapp/data/models/leaf_model.dart';
import 'package:leafapp/data/api/ml_api.dart';
import 'package:leafapp/logic/leaf/bloc/leaf_bloc.dart';
import 'package:leafapp/presentation/screens/result_screen/result_screen.dart';
import 'package:leafapp/presentation/utils/data.dart';
import 'package:leafapp/presentation/utils/repeaters.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  late LeafBloc _leafBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _leafBloc = BlocProvider.of<LeafBloc>(context);
  }

  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  Future<void> _getImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
    if (_image != null) {
      _showDialog();
    }
  }

  Future<void> _getImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
    if (_image != null) {
      _showDialog();
    }
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          title: Text(
            "Confirm Upload",
            style:
                GoogleFonts.roboto(fontWeight: FontWeight.w600, fontSize: 20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.file(
                File(_image!.path),
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.2,
                fit: BoxFit.cover,
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    _handleCancel();
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: GoogleFonts.roboto(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () {
                    _leafBloc.add(LeafPostEvent(imageFile: _image!));

                    Navigator.pop(context);
                  },
                  child: Text('Confirm'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _handleCancel() {
    setState(() {
      _image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.black,
        surfaceTintColor: Colors.white,
        title: Text(
          'Upload image',
          style: GoogleFonts.lato(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: BlocConsumer<LeafBloc, LeafState>(
            listener: (context, state) {
              if (state is LeafPostedState) {
                Navigator.pushNamed(context, '/result');
              }
            },
            builder: (context, state) {
              if (state is LeafPostingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is LeafPostError) {
                return Center(
                    child: Column(
                  children: [
                    Text("Image not appropriate"),
                    ElevatedButton(
                      onPressed: () {
                        _leafBloc.add(LeafResetStateEvent());
                      },
                      child: Text("Try again"),
                    )
                  ],
                ));
              }

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // _image == null
                    //     ? Text('No image selected.')
                    //     : Image.file(
                    //         File(_image!.path),
                    //         width: MediaQuery.of(context).size.width * 0.9,
                    //         height: MediaQuery.of(context).size.height * 0.5,
                    //       ),

                    Gap(20),
                    Text(
                      "Image Upload Options",
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Gap(30),
                    Text(
                      "Option 1: Select Image from Gallery",
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    Gap(10),
                    SizedBox(
                      height: 80,
                      child: ListView.builder(
                        itemCount: option1.length,
                        itemBuilder: (context, index) {
                          return Text(
                            option1[index],
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          );
                        },
                      ),
                    ),
                    Gap(20),
                    Center(
                      child: ElevatedButton(
                        onPressed: _getImageFromGallery,
                        child: Text('Select Image from Gallery'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          fixedSize: Size(300, 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                    Gap(25),
                    Text(
                      "Option 2: Take Image with Camera",
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    Gap(10),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        itemCount: option1.length,
                        itemBuilder: (context, index) {
                          return Text(
                            option2[index],
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          );
                        },
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: _getImageFromCamera,
                        child: Text('Select Image from Camera'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          fixedSize: Size(300, 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
