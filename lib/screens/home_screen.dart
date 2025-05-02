import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ra7al/blocs/blocs.dart';
import 'package:ra7al/repositories/adhan_repository.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Unauthenticated) {
            context.go('/login');
          }
        },
        child: BlocConsumer<AdhanBloc, AdhanState>(
          listener: (context, state) {
            if (state is AdhanError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("please check your GPS")));
            }
          },
          builder: (context, state) {
            if (state is AdhanLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is AdhanLoaded) {
              return Column(
                children: [
                  Expanded(child: Text(state.cityAndAdhan.city)),
                  Expanded(
                    child: PrayerTimesList(timings: state.cityAndAdhan.model),
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

            return const Center(child: Text('Pull to refresh prayer times'));
          },
        ),
      ),
    );
  }
}

class PrayerTimesList extends StatelessWidget {
  final AdhanModel timings;

  const PrayerTimesList({super.key, required this.timings});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PrayerTimeTile(title: 'Fajr', time: timings.fajr),
          PrayerTimeTile(title: 'Dhuhr', time: timings.dhuhr),
          PrayerTimeTile(title: 'Asr', time: timings.asr),
          PrayerTimeTile(title: 'Maghrib', time: timings.maghrib),
          PrayerTimeTile(title: 'Isha', time: timings.isha),
        ],
      ),
    );
  }
}

class PrayerTimeTile extends StatelessWidget {
  final String title;
  final String time;

  const PrayerTimeTile({super.key, required this.title, required this.time});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Text(title),
          Text(
            formatPrayerTime(time),
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}

String formatPrayerTime(String time) {
  final dateFormat = DateFormat('HH:mm');
  final parsedTime = DateFormat('HH:mm').parse(time);
  return dateFormat.format(parsedTime);
}
