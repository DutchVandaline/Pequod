import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pequod/Services/ApiServices.dart';
import 'package:pequod/Constants//HabitRecommendation.dart';
import 'package:pequod/Screens/MainScreen.dart';

String inputTodo = "";
String memo = "";
bool _showError = true;

class AddHabitScreen extends StatefulWidget {
  const AddHabitScreen({super.key});

  @override
  _AddHabitScreenState createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final todoController = TextEditingController();
  final memoController = TextEditingController();

  @override
  void initState() {
    inputTodo = "";
    memo = "";
    super.initState();
  }

  @override
  void dispose() {
    todoController.dispose();
    memoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          centerTitle: false,
          elevation: 0.0,
          shadowColor: Colors.transparent,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Center(
                    child: SizedBox(
                      height: 50.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: listInputEnvrionment.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListViewWidget(
                            inputText: listInputEnvrionment[index].inputTitle,
                            inputMemo: listInputEnvrionment[index].inputDetail,
                            todoController: todoController,
                            memoController: memoController,
                          );
                        },
                      ),
                    ),
                  ),
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
                        inputTodo = text;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10.0)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          hintText: "Type in a habit you want to make.",
                          hintStyle: const TextStyle(
                              color: Colors.grey, fontSize: 16.0)),
                      cursorColor: Theme.of(context).focusColor,
                      autofocus: true,
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
                        memo = text;
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
                GestureDetector(
                  onTap: () {
                    if (inputTodo.isEmpty) {
                      setState(() {
                        _showError = true;
                      });
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Please enter the habit you want to make!',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'FjallaOne',
                                fontSize: 18.0,
                              ),
                            ),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    } else {
                      ApiServices.postHabit(
                        inputTodo,
                        DateFormat("yyyy-MM-dd").format(DateTime.now()).toString(),
                        "false",
                        "10",
                        const Duration(hours: 2).toString(),
                        memo,
                      ).then((value) {
                        if (mounted) {
                          setState(() {
                            _showError = false;
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Habit Added Successfully',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'FjallaOne',
                                  fontSize: 18.0,
                                ),
                              ),
                              backgroundColor: Colors.teal,
                              duration: Duration(seconds: 2),
                            ),
                          );

                          // Navigate to MainScreen after successful habit addition
                          Navigator.pushAndRemoveUntil(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, a1, a2) => const MainScreen(
                                initialIndex: 1,
                              ),
                              transitionDuration: Duration.zero,
                              reverseTransitionDuration: Duration.zero,
                            ),
                                (route) => false,
                          );
                        }
                      }).catchError((error) {
                        if (mounted) {
                          setState(() {
                            _showError = true;
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Failed to Add Habit: $error',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'FjallaOne',
                                  fontSize: 18.0,
                                ),
                              ),
                              backgroundColor: Colors.red,
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        }
                      });
                    }
                  },
                  child: Container(
                    height: 50.0,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                      borderRadius: BorderRadius.circular(17.0),
                    ),
                    child: const Center(
                      child: Text(
                        "Add Habit",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ListViewWidget extends StatefulWidget {
  final String inputText;
  final String inputMemo;
  final todoController;
  final memoController;

  ListViewWidget(
      {required this.inputText,
      required this.inputMemo,
      required this.todoController,
      required this.memoController});

  @override
  State<ListViewWidget> createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () {
          setState(() {
            widget.todoController.text = widget.inputText;
            widget.memoController.text = widget.inputMemo;
            inputTodo = widget.inputText;
            memo = widget.inputMemo;
            _showError = false;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              widget.inputText,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          )),
        ),
      ),
    );
  }
}
