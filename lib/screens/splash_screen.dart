import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ra7al/blocs/authbloc/auth_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is Authenticated && context.mounted) {
          context.go('/home');
        } else if (state is Unauthenticated && context.mounted) {
          context.go('/login');
        }
      },
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/eee0388dcbe4f3d75252f755ec4ad8687e732e21.png',
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Image.asset(
              'assets/a3d000781770dd1005c52b77f2acab06cc141b58.png',
              height: MediaQuery.of(context).size.height * .5,
              width: MediaQuery.of(context).size.width * .5,
            ),
          ],
        ),
      ),
    );
  }
}
