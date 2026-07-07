import 'package:flutter/material.dart';
import 'package:hrms_app/core/router/app_route.dart';
import 'package:hrms_app/view_model/auth_vm.dart';
import 'package:hrms_app/view_model/department_vm.dart';
import 'package:hrms_app/view_model/designation_vm.dart';
import 'package:hrms_app/view_model/document_vm.dart';
import 'package:hrms_app/view_model/employee_vm.dart';
import 'package:hrms_app/view_model/payroll_vm.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => EmployeeViewModel()),
        ChangeNotifierProvider(create: (_) => DepartmentViewModel()),
        ChangeNotifierProvider(create: (_) => DesignationViewModel()),
        ChangeNotifierProvider(create: (_) => PayrollViewModel()),
        ChangeNotifierProvider(create: (_) => DocumentViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}
