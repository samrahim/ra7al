import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ra7al/blocs/blocs.dart';
import 'package:ra7al/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              'assets/eee0388dcbe4f3d75252f755ec4ad8687e732e21.png',
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Column(
              children: [
                CustomAppbar(),
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
                                  context.read<AdhanBloc>().add(
                                    FetchAdhanTiming(),
                                  );
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
                Container(
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),

                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'اظهار الكل',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 23, 182, 57),
                              ),
                            ),
                            Text(
                              "عروض موصى بها",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ListView.builder(
                            reverse: true,
                            itemCount: patrenairesmodels.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, ind) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 0),
                                margin: EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.green,
                                    width: 1.6,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/${patrenairesmodels[ind].imagePath}',
                                      height:
                                          MediaQuery.of(context).size.height *
                                          0.1,
                                      width:
                                          MediaQuery.of(context).size.width *
                                          0.4,
                                    ),
                                    Text(patrenairesmodels[ind].name),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PartenaireModel {
  final String name;
  final String imagePath;

  PartenaireModel({required this.name, required this.imagePath});
}

List<PartenaireModel> patrenairesmodels = [
  PartenaireModel(name: 'وكالات سياحية', imagePath: 'Vector.png'),
  PartenaireModel(name: 'عمرة', imagePath: 'Frame.png'),
  PartenaireModel(name: 'صمم رحلتك', imagePath: 'Asset 9 1.png'),
  PartenaireModel(name: 'مطاعم', imagePath: 'Frame(2).png'),
  PartenaireModel(name: 'إقامة', imagePath: 'Frame(1).png'),
  PartenaireModel(name: 'نقل', imagePath: 'SVGRepo_iconCarrier.png'),
];
