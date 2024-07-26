import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pequod/Services/ApiServices.dart';
import 'package:pequod/Screens/MainScreen.dart';
import 'package:pequod/Screens/VerificationScreen.dart';
import 'package:pequod/Widgets/ClimateCrisisTextWidget.dart';

String habitName = "";
String habitDetail = "";
String changedDate = DateFormat('yyyyMMdd').format(DateTime.now());

class HabitDetailScreen extends StatefulWidget {
  final String habitName;
  final String habitDescription;
  final int habitId;

  const HabitDetailScreen(
      {super.key,
      required this.habitId,
      required this.habitName,
      required this.habitDescription});

  @override
  State<HabitDetailScreen> createState() => _HabitDetailScreenState();
}

class _HabitDetailScreenState extends State<HabitDetailScreen> {
  final todoController = TextEditingController();
  final memoController = TextEditingController();

  @override
  void initState() {
    todoController.text = widget.habitName;
    memoController.text = widget.habitDescription;
    habitName = widget.habitName;
    habitDetail = widget.habitDescription;
    super.initState();
  }

  @override
  void dispose() {
    todoController.dispose();
    memoController.dispose();
    habitName = "";
    habitDetail = "";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        centerTitle: false,
        elevation: 0.0,
        shadowColor: Colors.transparent,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: ClimateChangeTextWidget("Detail"),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  if (widget.habitName == habitName &&
                      widget.habitDescription == habitDetail) {
                    print("It's same");
                  } else if(habitName.isEmpty){
                    print("There's nothing");
                  } else {
                    ApiServices.patchHabit(
                        widget.habitId, habitName, habitDetail);
                  }
                });
              },
              icon: const Icon(
                Icons.save_alt_outlined,
                size: 30.0,
              )),
          IconButton(
              onPressed: () {
                ApiServices.deleteHabit(widget.habitId);
                Navigator.pushAndRemoveUntil(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, a1, a2) => const MainScreen(initialIndex: 1,),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                      (route) => false,
                );
              },
              icon: const Icon(
                Icons.delete_forever_outlined,
                size: 30.0,
              )),
          const SizedBox(width: 10.0),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Text("Let's build some\nhabits!",
                      style: TextStyle(
                        fontFamily: 'FjallaOne',
                        fontWeight: FontWeight.bold,
                        fontSize: 35.0,
                      )),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 15.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: TextField(
                    controller: todoController,
                    style: TextStyle(fontSize: 17.0),
                    onChanged: (text) {
                      habitName = text;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10.0)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                        hintText: "Type in a habit you want to make.",
                        hintStyle: const TextStyle(
                            color: Colors.grey, fontSize: 16.0)),
                    cursorColor: Theme.of(context).focusColor,
                    autofocus: false,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 15.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.22,
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: TextField(
                    controller: memoController,
                    textInputAction: TextInputAction.done,
                    style: const TextStyle(fontSize: 17.0),
                    maxLines: 10,
                    onChanged: (text) {
                      habitDetail = text;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(10.0)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      hintText: "Write a memo about the habit.",
                      hintStyle:
                          const TextStyle(color: Colors.grey, fontSize: 16.0),
                    ),
                    cursorColor: Theme.of(context).focusColor,
                  ),
                ),
              ),
            ],
          ), //입력창
          Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VerificationScreen(
                              habitName: widget.habitName,
                              habitId: widget.habitId)));
                },
                child: Container(
                  height: 50.0,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                      borderRadius: BorderRadius.circular(17.0)),
                  child: const Center(
                      child: Text(
                    "Let's Verify Habit!",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                    textAlign: TextAlign.center,
                  )),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              )
            ],
          )
        ],
      ),
    );
  }
}
