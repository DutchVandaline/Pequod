import 'package:flutter/material.dart';
import 'HabitScreen.dart';
import 'LeaderBoardScreen.dart';
import 'HomeScreen.dart';
import 'SettingsScreen.dart';
import 'ShopScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: [
          ShopScreen(),
          HabitScreen(),
          HomeScreen(),
          LeaderBoardScreen(),
          SettingsScreen(),
        ][currentPageIndex],
        bottomNavigationBar: NavigationBar(
          indicatorColor: Colors.transparent,
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.shopping_bag_outlined), label: "Shop"),
            NavigationDestination(
                icon: Icon(Icons.list), label: "Habit"),
            NavigationDestination(
                icon: Icon(Icons.home_outlined), label: "Home"),
            NavigationDestination(
                icon: Icon(Icons.sports_score), label: "Score"),
            NavigationDestination(
                icon: Icon(Icons.settings_outlined), label: "Settings"),
          ],
          selectedIndex: currentPageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0.5,
        ),

      ),
    );
  }
}
