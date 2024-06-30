import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:pequod/API/Gemini_API_KEY.dart';
import 'package:pequod/Screens/MainScreen.dart';
import 'package:image_cropper/image_cropper.dart';

String apiKey = Constants.apikey;

class AnalysisScreen extends StatefulWidget {
  final String habitName;
  final String? imagePath;

  const AnalysisScreen(
      {super.key, required this.habitName, required this.imagePath});

  @override
  _AnalysisScreenState createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  String _analysisResult = "Analyzing...";
  bool _isLoading = true;
  Uint8List? _imageBytes;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    if (widget.imagePath != null) {
      final file = File(widget.imagePath!);
      final bytes = await file.readAsBytes();
      setState(() {
        _imageBytes = bytes;
      });
      _analyzeImage(bytes);
    } else {
      setState(() {
        _analysisResult = "No image path provided.";
        _isLoading = false;
      });
    }
  }

  Future<void> _analyzeImage(Uint8List imageBytes) async {
    try {
      final model = GenerativeModel(
          model: "gemini-1.5-flash",
          apiKey: apiKey,
          generationConfig: GenerationConfig(
            temperature: 1.0,
            topK: 64,
            topP: 0.95,
            maxOutputTokens: 8192,
            responseMimeType: "text/plain",
          ),
          systemInstruction: Content.text(
              "You are professional Image Analyzer. User gives an input of 'Habit' and single image. Analyze the image and find if it matches the given Habit. Tell user the analysis. Be terse. Your answer needs to be like following:"
              "Habit Match : false\n Reason : Image shows cat not tumbler"));

      final response = await model.generateContent([
        Content.text("Habit : ${widget.habitName}"),
        Content.data("image/png", imageBytes),
      ]);
      setState(() {
        _analysisResult = response.text!;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _analysisResult = "Error analyzing image: $error";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: "Hello There 👋\n",
                  style: TextStyle(
                      fontFamily: 'FjallaOne',
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColorLight),
                  children: [
                    TextSpan(
                      text: "AI is analysing...\n",
                      style: TextStyle(
                          fontFamily: 'FjallaOne',
                          fontSize: 35.0,
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context).primaryColorLight),
                    ),
                    TextSpan(
                      text: "\nHabit : ${widget.habitName}",
                      style: const TextStyle(
                          fontFamily: "FjallaOne",
                          fontSize: 17.0,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              Center(
                child: _isLoading
                    ? CircularProgressIndicator(
                  color: Theme.of(context).primaryColorLight,
                )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (_imageBytes != null)
                            Center(
                              child: ClipRRect(
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.9,
                                  height: MediaQuery.of(context).size.width * 0.8,
                                  child: FittedBox(
                                      fit: BoxFit.cover,
                                      child: Image.memory(_imageBytes!)),
                                ),
                              ),
                            ),
                          const SizedBox(height: 20.0,),
                          Text(
                            " $_analysisResult",
                            textAlign: TextAlign.start,
                            style: const TextStyle(fontSize: 18, fontFamily: 'FjallaOne'),
                          ),
                        ],
                      ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MainScreen()),
                      (route) => false);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Theme.of(context).primaryColorLight),
                  child: Center(
                    child: Text(
                      "Recieve Points",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'FjallaOne',
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
