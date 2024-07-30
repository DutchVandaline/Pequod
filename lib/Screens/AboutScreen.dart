import 'package:flutter/material.dart';
import 'package:pequod/Widgets/ClimateCrisisTextWidget.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: false,
        title: ClimateChangeTextWidget("Developers"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DeveloperWidget(
              imagePath: "team_leader",
              developerName: "Joonha Park*",
              inputJob: "iOS, Android, Backend"),
          DeveloperWidget(
              imagePath: "tomato_sua",
              developerName: "Suah Na",
              inputJob: "UX/UI Design"),
          DeveloperWidget(imagePath: "designer_yang", developerName: "Hyemin Yang", inputJob: "Design")
        ],
      ),
    );
  }
}

class DeveloperWidget extends StatelessWidget {
  String imagePath;
  String developerName;
  String inputJob;

  DeveloperWidget(
      {super.key,
      required this.imagePath,
      required this.developerName,
      required this.inputJob});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Text(
                "PEQUOD",
                style: TextStyle(
                    fontFamily: 'ClimateCrisis',
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColorLight),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.17,
                width: MediaQuery.of(context).size.width,
                child: Image.asset("assets/images/developers/$imagePath.png"),
              )
            ],
          ),
          Text(
            developerName,
            style: TextStyle(
                fontFamily: 'FjallaOne',
                fontSize: MediaQuery.of(context).size.width * 0.06,
                fontWeight: FontWeight.bold),
          ),
          Text(
            inputJob,
            style: TextStyle(
              fontFamily: 'FjallaOne',
              fontSize: MediaQuery.of(context).size.width * 0.05,
            ),
          )
        ],
      ),
    );
  }
}
