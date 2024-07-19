import 'package:flutter/material.dart';
import 'package:pequod/API/ApiServices.dart';
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
              height: 80.0,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
              child: Text(
                "Edit Account",
                style: TextStyle(fontSize: 17.0),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).canvasColor.withOpacity(0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SettingsWidget(
                    inputTitle: "Account",
                    inputicon: Icons.person_outlined,
                    nextScreen: const AccountScreen(),
                  ),
                  SettingsWidget(
                    inputTitle: "Notifications",
                    inputicon: Icons.notifications_none,
                    nextScreen: const SettingsScreen(),
                  ),
                  SettingsWidget(
                    inputTitle: "Privacy & Security",
                    inputicon: Icons.lock_outlined,
                    nextScreen: const SettingsScreen(),
                  ),
                  SettingsWidget(
                    inputTitle: "Help & Support",
                    inputicon: Icons.question_mark_outlined,
                    nextScreen: const SettingsScreen(),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
              child: Text(
                "Help",
                style: TextStyle(fontSize: 17.0),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).canvasColor.withOpacity(0.1),
              child: Column(
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
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 15.0,
                                ),
                                Icon(
                                  Icons.logout_outlined,
                                  size: 30.0,
                                ),
                                SizedBox(width: 20.0),
                                Text(
                                  "Logout",
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              ],
                            ),
                            Padding(
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
                  SettingsWidget(
                    inputTitle: "About",
                    inputicon: Icons.star_border,
                    nextScreen: const SettingsScreen(),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Logout'),
        content: const Text('Do you really want to Logout?'),
        backgroundColor: Theme.of(context).primaryColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              style: TextStyle(color: Theme.of(context).primaryColorLight),
            ),
          ),
          TextButton(
            onPressed: () async {
              await ApiServices.logout();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const SplashScreen()),
                  (route) => false);
            },
            child: Text(
              'Logout',
              style: TextStyle(color: Theme.of(context).primaryColorLight),
            ),
          ),
        ],
      );
    },
  );
}
