import 'package:go_router/go_router.dart';
import 'package:hrms_app/view/employee/add/add_employee.dart';
import 'package:hrms_app/view/employee/employee_details.dart';
import 'package:hrms_app/view/login/login_screen.dart';
import 'package:hrms_app/view/main_screen/main_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: "/login",
  routes: [
    GoRoute(path: "/login", builder: (context, state) => const LoginScreen()),
    GoRoute(path: "/main", builder: (context, state) => const MainScreen()),
    GoRoute(
      name: "employee-details",
      path: "/employee-details/:id",
      builder: (context, state) {
        final id = int.parse(state.pathParameters["id"]!);

        return EmployeeDetails(employeeId: id);
      },
    ),
    GoRoute(
      path: "/add-employee",
      name: "add-employee",
      builder: (context, state) => const AddEmployeeScreen(),
    ),
  ],
);
