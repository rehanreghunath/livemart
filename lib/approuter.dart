import 'package:go_router/go_router.dart';
import 'package:livemart/pages/screens/welcome_screen.dart';
import 'package:livemart/pages/auth/login.dart';
import 'package:livemart/pages/auth/signup.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignupPage(),
    ),
  ],
);


