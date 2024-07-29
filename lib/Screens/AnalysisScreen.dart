import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:pequod/Services/ApiServices.dart';
import 'package:pequod/Constants//Constants.dart';
import 'package:pequod/Screens/MainScreen.dart';
import 'package:pequod/Widgets/CountdownWidget.dart';

String apiKey = Constants.apikey;
bool receivePoint = false;
int animal_id = 0;

class AnalysisScreen extends StatefulWidget {
  final String habitName;
  final String? imagePath;
  final int habitId;

  const AnalysisScreen(
      {super.key,
      required this.habitName,
      required this.habitId,
      required this.imagePath});

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
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: FittedBox(
                                      fit: BoxFit.cover,
                                      child: Image.memory(_imageBytes!)),
                                ),
                              ),
                            ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            " $_analysisResult",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontSize: 18, fontFamily: 'FjallaOne'),
                          ),
                        ],
                      ),
              ),
              GestureDetector(
                onTap: () async {
                  setState(() {
                    if (_analysisResult.contains("true")) {
                      receivePoint = true;
                    } else {
                      receivePoint = false;
                    }
                  });
                  if (receivePoint) {
                    ApiServices.postHabitStatus(
                        widget.habitId.toString(),
                        Constants.changeDateFormat(DateTime.now()).toString(),
                        widget.habitName);
                    showWhomDialog(context);
                  } else {
                    int count = 0;
                    Navigator.popUntil(context, (route) {
                      return count++ == 2;
                    });
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Theme.of(context).primaryColorLight),
                  child: Center(
                    child: Text(
                      "Next Actions!",
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

  void showWhomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('Select Animal',
              style: TextStyle(
                  fontFamily: 'ClimateCrisis', fontWeight: FontWeight.w600)),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                const Text('Which animal do you want to use this item with?',
                    style: TextStyle(fontSize: 20.0),
                    textAlign: TextAlign.center),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.27,
                  child: StatefulBuilder(
                    builder: (BuildContext dialogContext,
                        StateSetter setDialogState) {
                      return FutureBuilder(
                        future: ApiServices.getAnimal(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData &&
                              snapshot.data!.isNotEmpty) {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                var animal = snapshot.data![index];
                                bool pressed = animal_id == animal['id'];
                                return GestureDetector(
                                  onTap: () {
                                    setDialogState(() {
                                      animal_id = animal['id'];
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0, vertical: 2.0),
                                    child: Container(
                                      height:
                                      MediaQuery.of(context).size.height *
                                          0.06,
                                      decoration: BoxDecoration(
                                          color: pressed
                                              ? Colors.teal
                                              : Colors.transparent,
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                          border: Border.all(
                                            color: Theme.of(context)
                                                .primaryColorLight,
                                          )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${animal['animal_name']}',
                                              style: const TextStyle(
                                                  fontFamily: 'FjallaOne',
                                                  fontSize: 22.0),
                                            ),
                                            Theme(
                                              data: Theme.of(context).copyWith(
                                                textTheme: Theme.of(context)
                                                    .textTheme
                                                    .apply(fontSizeFactor: 0.5),
                                              ),
                                              child: CountDownWidget(
                                                deadline: DateTime.parse(
                                                    animal['animal_deadline']),
                                                dead: animal['dead'],
                                                inputTextStyle: TextStyle(
                                                    fontFamily: 'FjallaOne',
                                                    fontSize: 15.0,
                                                    color: Theme.of(context)
                                                        .primaryColorLight),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ), // Assuming the data has 'id'
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return const Text('No animals available');
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                            color: Theme.of(context).primaryColorLight),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: TextButton(
                    onPressed: () async {
                      await ApiServices.patchHabitCompleted(widget.habitId, animal_id);
                      Navigator.pushAndRemoveUntil(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, a1, a2) => MainScreen(initialIndex: 2,),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                            (route) => false,
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 50.0,
                      decoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Center(
                        child: Text(
                          'Give time',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontFamily: 'FjallaOne',
                              fontSize: 20.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
