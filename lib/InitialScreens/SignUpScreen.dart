import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final EmailController = TextEditingController();
  final PasswordController = TextEditingController();
  final CheckPasswordController = TextEditingController();

  @override
  void dispose() {
    EmailController.dispose();
    PasswordController.dispose();
    CheckPasswordController.dispose();
    super.dispose();
  }

  Future<bool> createUser(String _enterEmail, String _enterPassword, String _enterName) async {
    var url = Uri.https('pequod-api-dlyou.run.goorm.site', '/api/user/create/');
    var response = await http.post(url, body: {
      'email': _enterEmail,
      'password': _enterPassword,
      'name': _enterName
    });
    if (response.statusCode >= 200 && response.statusCode < 300) {
      print('Sign-up successful');
      return true;
    } else {
      print('Error: ${response.statusCode}');
      print('Error body: ${response.body}');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20.0, bottom: 8.0),
              child: Text(
                "Hello\nthere!",
                style: TextStyle(fontSize: 40.0),
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
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
                          borderSide: const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(15.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(15.0)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(15.0)),
                      hintText: "Enter your Email for account",
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
              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10.0)),
                child: TextField(
                  controller: PasswordController,
                  onChanged: (text) {
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
                    hintText: "Enter your Password",
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10.0)),
                child: TextField(
                  controller: CheckPasswordController,
                  onChanged: (text) {
                    CheckPasswordController.text = text;
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
                    hintText: "Enter Your Password Again",
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
              onTap: () async {
                if (PasswordController.text.length < 5 &&
                    CheckPasswordController.text.length < 5) {
                  showErrorSnackBar(context, "Password is too short. Needs to be at least 5 letters");
                } else if (PasswordController.text !=
                    CheckPasswordController.text) {
                  showErrorSnackBar(context, "Password doesn\'t match. Please check again.");
                } else if (!EmailController.text.contains("@") ||
                    !EmailController.text.contains(".")) {
                  showErrorSnackBar(context, "Invalid Email format.");
                } else {
                  bool success = await createUser(EmailController.text, PasswordController.text, "User${DateTime.now()}");
                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.teal,
                      content: Text("You're all set! Please Log-In!", style: TextStyle(fontFamily: 'FjallaOne', fontSize: 18.0),),
                      duration: Duration(seconds: 2),
                    ));
                    Navigator.pop(context);
                  } else {
                    showErrorSnackBar(context, "The account already exists. Please log-in");
                  }
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60.0,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorLight,
                      borderRadius: BorderRadius.circular(15.0)),
                  child: Center(
                    child: Text(
                        "Sign-Up",
                        style: TextStyle(fontFamily: 'FjallaOne', fontSize: 20.0, color: Theme.of(context).scaffoldBackgroundColor,)
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Center(
                    child: Text(
                      "Do you already have Account?",
                      style: TextStyle(fontSize: 15.0),
                    ))),
            const SizedBox(
              height: 40.0,
            ),
          ],
        ),
      ),
    );
  }

  void showErrorSnackBar(BuildContext context, String inputError) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            inputError,
            style: const TextStyle(
                color: Colors.white,
                fontFamily: 'FjallaOne',
                fontSize: 18.0)),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({Key? key, required this.inputString}) : super(key: key);
  final String inputString;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.red.shade100,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              inputString,
              style: const TextStyle(color: Colors.red, fontFamily: 'FjallaOne'),
            ),
          ),
        ),
      ),
    );
  }
}
