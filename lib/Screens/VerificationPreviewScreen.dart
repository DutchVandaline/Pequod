import 'dart:io';
import 'package:flutter/material.dart';

class VerificationPreviewScreen extends StatefulWidget {
  final String? imagePath;

  const VerificationPreviewScreen({Key? key, this.imagePath}) : super(key: key);

  @override
  State<VerificationPreviewScreen> createState() => _VerificationPreviewScreenState();
}

class _VerificationPreviewScreenState extends State<VerificationPreviewScreen> {
  @override
  Widget build(BuildContext context) {
    print(widget.imagePath);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Center(
          child: widget.imagePath != null
              ? Image.file(
            File(widget.imagePath ?? ""),
            fit: BoxFit.cover,
          )
              : const Text("error ")),
    );
  }
}
