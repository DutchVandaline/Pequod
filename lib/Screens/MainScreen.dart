import 'package:flutter/material.dart';
import 'package:pequod/Screens/HabitScreen.dart';
import 'package:pequod/Screens/HomeScreen.dart';
import 'TragedyScreen.dart';
import 'SettingsScreen.dart';
import 'ShopScreen.dart';

class MainScreen extends StatefulWidget {
  final int initialIndex;

  const MainScreen({super.key, this.initialIndex = 2});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int currentPageIndex;

  @override
  void initState() {
    currentPageIndex = widget.initialIndex;
    super.initState();
  }

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
              label: "Tragedy"),
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
