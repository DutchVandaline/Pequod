import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pequod/Services/ApiServices.dart';
import 'package:pequod/InitialScreens/SignUpScreen.dart';
import 'package:pequod/Screens/MainScreen.dart';

bool displayError = false;
class AnimalSelectionScreen extends StatefulWidget {
  const AnimalSelectionScreen({Key? key}) : super(key: key);

  @override
  State<AnimalSelectionScreen> createState() => _AnimalSelectionScreenState();
}

class _AnimalSelectionScreenState extends State<AnimalSelectionScreen> {
  final NameController = TextEditingController();
  final PageController pageController = PageController();

  @override
  void dispose() {
    NameController.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, bottom: 8.0),
                  child: Container(
                    child: const Text(
                      "Choose Your\nAnimal!",
                      style: TextStyle(fontSize: 40.0, fontFamily: 'FjallaOne'),
                    ),
                  ),
                ),
                displayError
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: Colors.red.shade100,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "You need to choose at least one animal!",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(
                        height: 20.0,
                      ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  child: Scrollbar(
                    controller: pageController,
                    interactive: true,
                    thumbVisibility: true,
                    child: PageView(
                      controller: pageController,
                      scrollDirection: Axis.horizontal,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/animals/sea_turtle.png"),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/animals/whale.png"),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/animals/polar_bear.png"),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: TextField(
                      controller: NameController,
                      maxLength: 9,
                      onChanged: (text) {
                        NameController.text = text;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColorLight),
                            borderRadius: BorderRadius.circular(15.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColorLight),
                            borderRadius: BorderRadius.circular(15.0)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColorLight),
                            borderRadius: BorderRadius.circular(15.0)),
                        hintText: "Enter your Animal Name",
                        hintStyle: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.normal),
                      ),
                      cursorColor: Theme.of(context).primaryColorLight,
                      autofocus: false,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0,),
              ],
            ),
            GestureDetector(
              onTap: () {
                if (NameController.text.isEmpty) {
                  setState(() {
                    displayError = !displayError;
                  });
                } else {
                  ApiServices.postAnimal(
                      NameController.text,
                      pageController.page!.round().toString(),
                      DateTime.now().add(const Duration(days: 2)).toString(),
                      "false");

                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const MainScreen(initialIndex: 2,)),
                          (route) => false);
                  NameController.text = "";
                }
              },
              child: Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60.0,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorLight,
                      borderRadius: BorderRadius.circular(15.0)),
                  child: Center(
                    child: Text(
                      "That's my Choice!",
                      style: TextStyle(
                          fontFamily: 'FjallaOne',
                          color: Theme.of(context).cardColor,
                          fontSize: 20.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
