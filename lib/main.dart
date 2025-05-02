import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ra7al/blocs/blocs.dart';
import 'package:ra7al/consts/consts.dart';
import 'package:ra7al/repositories/adhan_repository.dart';
import 'package:ra7al/router/app_router.dart';
import 'package:ra7al/firebase_options.dart';
import 'package:ra7al/repositories/authrepository.dart';
import 'package:ra7al/services/dio_client.dart';
import 'package:ra7al/services/location_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthRepository()),
        RepositoryProvider<AdhanRepository>(
          create:
              (context) => AdhanRepository(
                dioClient: DioClient(
                  dio: Dio(
                    BaseOptions(
                      baseUrl: adhanBaseUrl,
                      connectTimeout: const Duration(seconds: 60),
                    ),
                  ),
                ),
                locationService: LocationService(),
              ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create:
                (context) => AuthBloc(
                  authRepository: RepositoryProvider.of<AuthRepository>(
                    context,
                  ),
                )..add(const AuthStateChanged(null)),
          ),
          BlocProvider(
            create:
                (context) => AdhanBloc(
                  adhanRepository: RepositoryProvider.of<AdhanRepository>(
                    context,
                  ),
                ),
          ),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,

      builder: (context, child) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _handleInitialLocation(context);
        });
        return child!;
      },
    );
  }

  void _handleInitialLocation(BuildContext context) {
    final adhanBloc = context.read<AdhanBloc>();
    if (adhanBloc.state is! AdhanLoaded) {
      adhanBloc.add(FetchAdhanTiming());
    }
  }
}
