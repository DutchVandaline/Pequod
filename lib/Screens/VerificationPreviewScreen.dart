import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pequod/Screens/AnalysisScreen.dart';

class VerificationPreviewScreen extends StatefulWidget {
  final String? imagePath;
  final String habitName;
  final int habitId;

  const VerificationPreviewScreen(
      {super.key,
      required this.imagePath,
      required this.habitName,
      required this.habitId});

  @override
  State<VerificationPreviewScreen> createState() =>
      _VerificationPreviewScreenState();
}

class _VerificationPreviewScreenState extends State<VerificationPreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF202023),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 25.0,
              color: Colors.white,
            )),
        backgroundColor: const Color(0xFF202023),
      ),
      body: widget.imagePath != null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: Image.file(
                    File(widget.imagePath ?? ""),
                    fit: BoxFit.cover,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                    "Image will be analysed by AI wheather it matches the habit.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AnalysisScreen(
                                    habitName: widget.habitName,
                                    habitId: widget.habitId,
                                    imagePath: widget.imagePath,
                                  )));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: const Color(0xFFe5e3d8)),
                      child: const Center(
                        child: Text(
                          "ANALYZE IMAGE WITH AI",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'FjallaOne',
                              color: Color(0xFF202023)),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          : const Center(
              child: Text(
              "Error occurred while loading the image",
              textAlign: TextAlign.center,
            )),
    );
  }
}
