import 'package:flutter/material.dart';
import 'package:pequod/Screens/AboutScreen.dart';
import 'package:pequod/Screens/MainScreen.dart';
import 'package:pequod/Services/ApiServices.dart';
import 'package:pequod/Screens/AccountScreen.dart';
import 'package:pequod/Widgets/ClimateCrisisTextWidget.dart';
import 'package:pequod/Widgets/SettingsWidget.dart';

import 'SplashScreen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          elevation: 0.0,
          shadowColor: Colors.transparent,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: ClimateChangeTextWidget("Settings"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 60.0,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
              child: Text(
                "Privacy",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SettingsWidget(
                  inputTitle: "Account",
                  inputicon: Icons.person_outlined,
                  nextScreen: const AccountScreen(),
                ),
                SettingsWidget(
                  inputTitle: "About",
                  inputicon: Icons.star_border,
                  nextScreen: const AboutScreen(),
                ),
        GestureDetector(
          onTap: () {
            Navigator.pushAndRemoveUntil(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) => const MainScreen(initialIndex: 2,),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
                    (route) => false);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 15.0),
                    Icon(
                      Icons.refresh,
                      size: 30.0,
                    ),
                    const SizedBox(width: 20.0),
                    Text(
                        "Refresh",
                        style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05)
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 25.0,
                  ),
                )
              ],
            ),
          ),
        ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
              child: Text("Logout",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04)),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    showLogoutDialog(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 55.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 15.0,
                              ),
                              const Icon(
                                Icons.logout_outlined,
                                size: 30.0,
                              ),
                              const SizedBox(width: 20.0),
                              Text("Logout",
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.05)),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 25.0,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Logout',
            style: TextStyle(
                fontFamily: 'ClimateCrisis', fontWeight: FontWeight.w600),
          ),
          content: const Text(
            "Do you really want to Log-out?",
            style: TextStyle(fontSize: 17.0, fontFamily: 'FjallaOne'),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          actions: [
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Theme.of(context).primaryColorLight),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: TextButton(
                    onPressed: () async {
                      await ApiServices.logout();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const SplashScreen()),
                              (route) => false);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 50.0,
                      decoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Center(
                        child: Text(
                          'Logout',
                          style: TextStyle(
                              color: Theme.of(context).primaryColorLight,
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
