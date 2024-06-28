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
  int currentPageIndex = 2;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: [
          ShopScreen(),
          HabitScreen(),
          HomeScreen(),
          LeaderBoardScreen(),
          SettingsScreen(),
        ][currentPageIndex],
        bottomNavigationBar: NavigationBar(
          indicatorColor: Theme.of(context).hoverColor,
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.shopping_bag_outlined, size: 30.0), label: "Shop"),
            NavigationDestination(
                icon: Icon(Icons.list, size: 30.0), label: "Habit"),
            NavigationDestination(
                icon: Icon(Icons.directions_boat_filled_outlined, size: 30.0), label: "Home"),
            NavigationDestination(
                icon: Icon(Icons.leaderboard_outlined, size: 30.0), label: "Score"),
            NavigationDestination(
                icon: Icon(Icons.settings_outlined, size: 30.0), label: "Settings"),
          ],
          selectedIndex: currentPageIndex,

          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0.5,
        ),

      ),
    );
  }
}
