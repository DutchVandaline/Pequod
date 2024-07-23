import 'package:flutter/material.dart';
import 'package:pequod/InitialScreens/SignUpScreen.dart';
import 'package:http/http.dart' as http;
import 'package:pequod/Screens/MainScreen.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

bool displayError = false;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final EmailController = TextEditingController();
  final PasswordController = TextEditingController();

  @override
  void dispose() {
    EmailController.dispose();
    PasswordController.dispose();
    super.dispose();
  }

  void createToken(String _enterEmail, String _enterPassword) async {
    var url = Uri.https('pequod-api-dlyou.run.goorm.site', '/api/user/token/');
    var response = await http
        .post(url, body: {'email': _enterEmail, 'password': _enterPassword});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (response.statusCode == 200) {
      print(response.body);
      Map<String, dynamic> jsonData = json.decode(response.body);
      String token = jsonData['token'];
      userAuthorize(token);
      prefs.setString("UserToken", token);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
          (route) => false);
    } else {
      print('Error: ${response.statusCode}');
      print('Error body: ${response.body}');
      setState(() {
        displayError = true;
      });
    }
  }

  void userAuthorize(String _userToken) async {
    var url =
        Uri.https('pequod-api-dlyou.run.goorm.site', '/api/habit/habits/');
    var response =
        await http.get(url, headers: {'Authorization': 'Token $_userToken'});

    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);
      print('Response Data: $responseData');
    } else {
      print('Error: ${response.statusCode}, ${response.body}');
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      displayError = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 8.0),
              child: Container(
                child: const Text(
                  "Welcome\nback!",
                  style: TextStyle(fontSize: 40.0),
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
                            "없는 계정이거나 비밀번호가 일치하지 않습니다.",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox(
                    height: 20.0,
                  ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10.0)),
                child: TextField(
                  controller: EmailController,
                  onChanged: (text) {
                    EmailController.text = text;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(15.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(15.0)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(15.0)),
                      hintText: "Enter your Email",
                      hintStyle: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.normal),
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Theme.of(context).primaryColorLight,
                      )),
                  cursorColor: Theme.of(context).primaryColorLight,
                  autofocus: false,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10.0)),
                child: TextField(
                  controller: PasswordController,
                  onChanged: (text) {
                    //inputPassword = text;
                    PasswordController.text = text;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(15.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(15.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(15.0)),
                    hintText: "Enter your password",
                    hintStyle: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.normal),
                    prefixIcon: Icon(
                      Icons.password_outlined,
                      color: Theme.of(context).primaryColorLight,
                    ),
                  ),
                  cursorColor: Theme.of(context).primaryColorLight,
                  obscureText: true,
                  autofocus: false,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                createToken(EmailController.text, PasswordController.text);
                setState(() {
                  EmailController.text = "";
                  PasswordController.text = "";
                });
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
                      "Log-In",
                      style: TextStyle(
                          fontFamily: 'FjallaOne',
                          color: Theme.of(context).cardColor,
                          fontSize: 20.0),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpScreen()));
                  setState(() {
                    displayError = false;
                  });
                },
                child: const Center(
                  child: Text.rich(
                    TextSpan(
                      text: 'First time to ',
                      style: TextStyle(
                          fontSize: 15.0, decoration: TextDecoration.none),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Pequod?',
                            style: TextStyle(
                                decoration: TextDecoration.underline)),
                      ],
                    ),
                  ),
                )),
            const SizedBox(
              height: 40.0,
            ),
          ],
        ),
      ),
    );
  }
}
