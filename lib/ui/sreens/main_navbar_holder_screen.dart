import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/sreens/canclled_task_screen.dart';
import 'package:task_manager_app/ui/sreens/completed_task_screen.dart';
import 'package:task_manager_app/ui/sreens/new_task_screen.dart';
import 'package:task_manager_app/ui/sreens/progress_task_screen.dart';

import '../widgets/tm_appbar.dart';

class MainNavbarHolderScreen extends StatefulWidget {
  const MainNavbarHolderScreen({super.key});
  static const String name = '/dashboard';

  @override
  State<MainNavbarHolderScreen> createState() => _MainNavbarHolderScreenState();
}

class _MainNavbarHolderScreenState extends State<MainNavbarHolderScreen> {
  int _selectedIndex = 0;

  final List<Widget> pages = [
    NewTaskScreen(),
    ProgressTaskScreen(),
    CanclledTaskScreen(),
    CompletedTaskScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          _selectedIndex = index;
          setState(() {});
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.new_label_outlined),
            label: 'New',
          ),
          NavigationDestination(
            icon: Icon(Icons.refresh_outlined),
            label: 'Progress',
          ),
          NavigationDestination(icon: Icon(Icons.close), label: 'Canclled'),
          NavigationDestination(icon: Icon(Icons.done), label: 'Completed'),
        ],
      ),
    );
  }
}
