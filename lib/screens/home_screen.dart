import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ra7al/blocs/blocs.dart';
import 'package:ra7al/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('رحال'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(LogoutRequested());
            },
          ),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is Authenticated && state.user.photoURL != null) {
                return CircleAvatar(child: Image.network(state.user.photoURL!));
              } else {
                return SizedBox();
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is Unauthenticated) {
                context.go('/login');
              }
            },
            child: BlocConsumer<AdhanBloc, AdhanState>(
              listener: (context, state) {
                if (state is AdhanError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("please check your GPS")),
                  );
                }
              },
              builder: (context, state) {
                if (state is AdhanLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is AdhanLoaded) {
                  return Column(
                    children: [
                      SizedBox(child: Text(state.cityAndAdhan.city)),
                      Container(
                        margin: EdgeInsets.all(8),

                        child: PrayerTimesList(
                          timings: state.cityAndAdhan.model,
                        ),
                      ),
                    ],
                  );
                }

                if (state is AdhanError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Error: ${state.message}'),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<AdhanBloc>().add(FetchAdhanTiming());
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                return const Center(
                  child: Text('Pull to refresh prayer times'),
                );
              },
            ),
          ),
          Suggestion(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [Text("عروض"), Suggestions()],
          ),
        ],
      ),
    );
  }
}

class Suggestions extends StatelessWidget {
  const Suggestions({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green, width: 1.4),
              ),
              child: Column(
                children: [
                  Image.asset('assets/more.png'),
                  SizedBox(height: 8),
                  Text("3omra"),
                ],
              ),
            ),
          ),

          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green, width: 1.4),
              ),
              child: Column(
                children: [
                  Image.asset('assets/voyage.png'),
                  SizedBox(height: 8),
                  Text("3omra"),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green, width: 1.4),
              ),
              child: Column(
                children: [
                  Image.asset('assets/kaaba.png'),
                  SizedBox(height: 8),
                  Text("3omra"),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green, width: 1.4),
              ),
              child: Column(
                children: [
                  Image.asset('assets/agence.png'),
                  SizedBox(height: 8),
                  Text("3omra"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Suggestion extends StatelessWidget {
  const Suggestion({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "عروض موصى بها",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  height: MediaQuery.of(context).size.height / 6,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width * 0.44,
                  'assets/Screenshot 2025-05-03 at 01-21-09 (JPEG Image 486 × 1080 pixels) — Scaled (89%).png',
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  "assets/Untitled.jpeg",
                  width: MediaQuery.of(context).size.width * 0.44,
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height / 6,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
