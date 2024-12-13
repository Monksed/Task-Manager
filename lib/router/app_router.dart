import 'package:fbase/screen/task_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:fbase/screen/login_screen.dart';
import 'package:fbase/screen/register_screen.dart';


class AppRouter {
  static final router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/task',
        builder: (context, state) => const TaskScreen(),
      ),
    ],
  );
}