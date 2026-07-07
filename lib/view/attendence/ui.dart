// import 'package:flutter/material.dart';
// import 'package:hrms_app/core/theme/app_color.dart';
// import 'package:hrms_app/view/attendance/widgets/attendance_card.dart';
// import 'package:hrms_app/view/attendance/widgets/attendance_summary.dart';

// class AttendanceScreen extends StatefulWidget {
//   const AttendanceScreen({super.key});

//   @override
//   State<AttendanceScreen> createState() => _AttendanceScreenState();
// }

// class _AttendanceScreenState extends State<AttendanceScreen> {

//   final searchController = TextEditingController();

//   final List<Map<String, dynamic>> employees = [
//     {
//       "name": "John Doe",
//       "designation": "Software Engineer",
//       "checkIn": "09:02 AM",
//       "checkOut": "06:05 PM",
//       "status": "Present",
//     },
//     {
//       "name": "Sarah",
//       "designation": "HR Manager",
//       "checkIn": "--",
//       "checkOut": "--",
//       "status": "Absent",
//     },
//     {
//       "name": "Alex",
//       "designation": "UI Designer",
//       "checkIn": "09:45 AM",
//       "checkOut": "--",
//       "status": "Late",
//     },
//     {
//       "name": "David",
//       "designation": "Flutter Developer",
//       "checkIn": "--",
//       "checkOut": "--",
//       "status": "Leave",
//     },
//   ];

//   List<Map<String, dynamic>> filtered = [];

//   @override
//   void initState() {
//     super.initState();

//     filtered = List.from(employees);
//   }

//   void search(String value) {
//     filtered = employees.where((employee) {
//       return employee["name"]
//           .toLowerCase()
//           .contains(value.toLowerCase());
//     }).toList();

//     setState(() {});
//   }

//   Future<void> refresh() async {
//     await Future.delayed(const Duration(seconds: 1));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(

//       backgroundColor: AppColors.scaffold,

//       appBar: AppBar(
//         backgroundColor: AppColors.primary,
//         elevation: 0,
//         title: const Text(
//           "Attendance",
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),

//       floatingActionButton: FloatingActionButton.extended(
//         backgroundColor: AppColors.primary,
//         onPressed: () {},
//         icon: const Icon(Icons.add),
//         label: const Text("Mark Attendance"),
//       ),

//       body: RefreshIndicator(

//         onRefresh: refresh,

//         child: ListView(

//           padding: const EdgeInsets.all(16),

//           children: [

//             TextField(

//               controller: searchController,

//               onChanged: search,

//               decoration: InputDecoration(

//                 hintText: "Search Employee",

//                 prefixIcon: const Icon(Icons.search),

//                 filled: true,

//                 fillColor: Colors.white,

//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(14),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),

//             const SizedBox(height: 20),

//             const AttendanceSummary(),

//             const SizedBox(height: 20),

//             const Text(
//               "Today's Attendance",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),

//             const SizedBox(height: 10),

//             ...filtered.map(
//               (employee) => AttendanceCard(
//                 name: employee["name"],
//                 designation: employee["designation"],
//                 checkIn: employee["checkIn"],
//                 checkOut: employee["checkOut"],
//                 status: employee["status"],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }