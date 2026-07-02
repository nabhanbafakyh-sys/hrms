import 'package:go_router/go_router.dart';
import 'package:hrms_app/view/login/login_screen.dart';
import 'package:hrms_app/view/main_screen/main_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: "/login",
  routes: [
    GoRoute(path: "/login", builder: (context, state) => const LoginScreen()),
    GoRoute(path: "/main", builder: (context, state) => const MainScreen()),
  ],
);
