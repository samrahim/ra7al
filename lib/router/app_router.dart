import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ra7al/bloc/auth_bloc.dart';
import 'package:ra7al/screens/screens.dart';

// app_router.dart
final goRouter = GoRouter(
  redirect: (BuildContext context, GoRouterState state) {
    final authBloc = context.read<AuthBloc>();
    final isAuthenticated = authBloc.state is Authenticated;
    final isLoggingIn = state.uri.toString() == '/login';

    if (!isAuthenticated && !isLoggingIn) {
      return '/login';
    }

    if (isAuthenticated && isLoggingIn) {
      return '/home';
    }

    return null;
  },
  routes: [
    GoRoute(path: '/', redirect: (_, __) => '/splash'),
    GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
  ],
);
