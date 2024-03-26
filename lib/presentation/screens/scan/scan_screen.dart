import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leafapp/logic/leaf/bloc/leaf_bloc.dart';
import 'package:leafapp/presentation/utils/data.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  late LeafBloc _leafBloc;

  @override
  void initState() {
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
            "Leaf Image Preview",
            style:
                GoogleFonts.roboto(fontWeight: FontWeight.w600, fontSize: 18),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 3,
              ),
              Text(
                " Your uploaded image will be automatically resized to 150x150 pixels for efficient processing.",
                style: GoogleFonts.roboto(
                  fontSize: 10,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 15,
              ),
              ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                child: Image.file(
                  File(_image!.path),
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.2,
                  fit: BoxFit.cover,
                ),
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
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () {
                    _leafBloc.add(LeafPostEvent(imageFile: _image!));

                    Navigator.pop(context);
                  },
                  child: const Text('Confirm'),
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
        child: BlocConsumer<LeafBloc, LeafState>(
          listener: (context, state) {
            if (state is LeafPostedState) {
              Navigator.pushNamed(context, '/result',
                  arguments: {"image": _image!});
            }
          },
          builder: (context, state) {
            if (state is LeafPostingState) {
              return Padding(
                padding: const EdgeInsets.only(top: 250),
                child: Center(
                  child: Column(
                    children: [
                      SpinKitCircle(
                        size: 50,
                        color: Colors.green[600],
                      ),
                      const Gap(20),
                      Text(
                        "Processing Image ! May take few seconds...",
                        style: GoogleFonts.lato(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is LeafPostError) {
              return Center(
                  child: Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Column(
                  children: [
                    Text(
                      "Unable to Process Image",
                      style: GoogleFonts.roboto(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "We regret to inform you that the uploaded image cannot be processed at this time due to inappropriate content. Our service is designed to identify and classify leaves for legitimate purposes only. Please ensure that future uploads adhere to our content guidelines to receive accurate predictions. If you believe this is an error or have any questions, please contact our support team for assistance.",
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 100),
                        shape: const RoundedRectangleBorder(),
                      ),
                      onPressed: () {
                        _leafBloc.add(LeafResetStateEvent());
                      },
                      child: const Text("Try again"),
                    )
                  ],
                ),
              ));
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Gap(20),
                  Text(
                    "Image Upload Options",
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const Gap(30),
                  Text(
                    "Option 1: Select Image from Gallery",
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  const Gap(10),
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
                  const Gap(20),
                  Center(
                    child: ElevatedButton(
                      onPressed: _getImageFromGallery,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        fixedSize: const Size(300, 10),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Select Image from Gallery'),
                    ),
                  ),
                  const Gap(25),
                  Text(
                    "Option 2: Take Image with Camera",
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  const Gap(10),
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        fixedSize: const Size(300, 10),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Select Image from Camera'),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
