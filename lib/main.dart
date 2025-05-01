import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ra7al/bloc/auth_bloc.dart';
import 'package:ra7al/router/app_router.dart';
import 'package:ra7al/firebase_options.dart';
import 'package:ra7al/repositories/authrepository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  AuthBloc(authRepository: AuthRepository())
                    ..add(const AuthStateChanged(null)),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
      title: 'Auth Demo',
    );
  }
}
