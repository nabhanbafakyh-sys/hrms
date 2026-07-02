import 'package:flutter/material.dart';
import 'package:hrms_app/view/employee/employee_screen.dart';
import 'package:hrms_app/view/main_screen/widgets/drawer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    const EmployeeScreen(),
    const Center(child: Text("Attendance")),
    const Center(child: Text("Leave")),
    const Center(child: Text("Departments")),
    const Center(child: Text("Payroll")),
    const Center(child: Text("Reports")),
    const Center(child: Text("Settings")),
  ];

  final List<String> titles = [
    "Employees",
    "Attendance",
    "Leave",
    "Departments",
    "Payroll",
    "Reports",
    "Settings",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(
        selectedIndex: selectedIndex,
        onItemSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
          Navigator.pop(context);
        },
      ),
      appBar: AppBar(
        title: Text(titles[selectedIndex]),
        centerTitle: true,
        actions: [
          Icon(Icons.mail),
          SizedBox(width: 10),
          Icon(Icons.notifications_none_outlined),
          SizedBox(width: 15),
        ],
      ),
      body: pages[selectedIndex],
    );
  }
}
