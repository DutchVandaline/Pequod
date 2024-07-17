import 'package:flutter/material.dart';
import 'package:pequod/Screens/ArchiveScreen.dart';
import 'package:pequod/Screens/HabitScreen.dart';
import 'TragedyScreen.dart';
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

  final List<Widget> _pages = [
    const ShopScreen(),
    const HabitScreen(),
    const HomeScreen(),
    const TragedyScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentPageIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        indicatorColor: Theme.of(context).hoverColor,
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
        destinations: [
          NavigationDestination(
              icon: Icon(
                Icons.shopping_bag_outlined,
                size: 30.0,
                color: Theme.of(context).primaryColorLight,
              ),
              label: "Shop"),
          NavigationDestination(
              icon: Icon(
                Icons.list,
                size: 30.0,
                color: Theme.of(context).primaryColorLight,
              ),
              label: "Habit"),
          NavigationDestination(
              icon: Icon(
                Icons.directions_boat_filled_outlined,
                size: 30.0,
                color: Theme.of(context).primaryColorLight,
              ),
              label: "Home"),
          NavigationDestination(
              icon: Icon(
                Icons.groups,
                size: 30.0,
                color: Theme.of(context).primaryColorLight,
              ),
              label: "Score"),
          NavigationDestination(
              icon: Icon(
                Icons.settings_outlined,
                size: 30.0,
                color: Theme.of(context).primaryColorLight,
              ),
              label: "Settings"),
        ],
      ),
    );
  }
}
