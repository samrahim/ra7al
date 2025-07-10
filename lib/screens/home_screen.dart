import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ra7al/blocs/blocs.dart';
import 'package:ra7al/screens/agences.dart';
import 'package:ra7al/screens/omra.dart';
import 'package:ra7al/screens/residence.dart';
import 'package:ra7al/screens/restaurents.dart' show Restaurents;
import 'package:ra7al/screens/transport.dart';
import 'package:ra7al/screens/voyage.dart';
import 'package:ra7al/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _controller = ScrollController();
  bool _showLeft = false;
  bool _showRight = true;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateIcons();
    });
  }

  void _scrollListener() {
    _updateIcons();
  }

  void _updateIcons() {
    final maxScroll = _controller.position.maxScrollExtent;
    final current = _controller.offset;
    setState(() {
      _showLeft = current > 0;
      _showRight = current < maxScroll;
    });
  }

  void _scrollLeft() {
    final offset = (_controller.offset - 200).clamp(
      0.0,
      _controller.position.maxScrollExtent,
    );
    _controller.animateTo(
      offset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void _scrollRight() {
    final offset = (_controller.offset + 200).clamp(
      0.0,
      _controller.position.maxScrollExtent,
    );
    _controller.animateTo(
      offset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    _controller.dispose();
    super.dispose();
  }

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
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomAppbar(),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Directionality(
                      textDirection: TextDirection.rtl,

                      child: SearchBar(
                        leading: Icon(Icons.search),
                        hintText: 'ابحث عن وجهتك القادمة',
                        backgroundColor: MaterialStateProperty.all(
                          Colors.white,
                        ),
                        onSubmitted: (query) {
                          if (query.isNotEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: Duration(seconds: 1),
                                backgroundColor: Color.fromARGB(
                                  230,
                                  23,
                                  182,
                                  57,
                                ),
                                content: Text(
                                  'بحث عن: $query (الميزة قيد التطوير)',
                                  textDirection: TextDirection.rtl,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),

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
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (state is AdhanLoaded) {
                          return Column(
                            children: [
                              SizedBox(child: Text(state.cityAndAdhan.city)),
                              Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),

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
                                Text('مشكلة في تحميل مواقيت الصلاة '),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () {
                                    context.read<AdhanBloc>().add(
                                      FetchAdhanTiming(),
                                    );
                                  },
                                  child: const Text('اعد التحميل'),
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
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),

                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "عروض",

                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),

                        Expanded(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 40,
                                ),
                                child: ListView.builder(
                                  controller: _controller,
                                  reverse: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: patrenairesmodels.length,
                                  itemBuilder: (context, ind) {
                                    final partenaire = patrenairesmodels[ind];
                                    return InkWell(
                                      onTap: () => _onItemTap(partenaire),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                            0.25,

                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 4,
                                          vertical: 4,
                                        ),

                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          color: Colors.white,
                                          border: Border.all(
                                            color: Colors.green,
                                            width: 1.6,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/${partenaire.imagePath}',
                                              height:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.height *
                                                  0.05,
                                              width:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  0.28,
                                            ),
                                            Text(partenaire.name),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              if (_showRight)
                                Positioned(
                                  left: 0,
                                  child: IconButton(
                                    icon: const Icon(Icons.arrow_back_ios),
                                    onPressed: _scrollRight,
                                  ),
                                ),
                              if (_showLeft)
                                Positioned(
                                  right: 0,
                                  child: IconButton(
                                    icon: const Icon(Icons.arrow_forward_ios),
                                    onPressed: _scrollLeft,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),

                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 2),
                        Center(
                          child: Text(
                            "اكتشف",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: ListView.builder(
                              reverse: true,
                              itemCount: explore.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, ind) {
                                final partenaire = explore[ind];
                                return InkWell(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: Duration(seconds: 1),
                                        backgroundColor: Color.fromARGB(
                                          230,
                                          23,
                                          182,
                                          57,
                                        ),
                                        content: Text(
                                          'الميزة قيد التطوير',
                                          textDirection: TextDirection.rtl,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * .25,
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 4,
                                      vertical: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Colors.green,
                                        width: 1.6,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/${partenaire.imagePath}',
                                          height:
                                              MediaQuery.of(
                                                context,
                                              ).size.height *
                                              0.05,
                                          width:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.28,
                                        ),
                                        Text(partenaire.name),
                                      ],
                                    ),
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
            ),
            Positioned(bottom: 16, child: _navBar()),
          ],
        ),
      ),
    );
  }

  Widget _navBar() {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      height: 65,
      margin: EdgeInsets.only(right: 10, left: 10, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              // Do nothing for الرئيسية
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.home,
                  color: Color.fromARGB(255, 23, 182, 57),
                ),
                Text(
                  'الرئيسية',
                  style: TextStyle(color: Color.fromARGB(255, 23, 182, 57)),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 1),
                  backgroundColor: Color.fromARGB(230, 23, 182, 57),
                  content: Text(
                    'ميزة "عروض" قيد التطوير',
                    textDirection: TextDirection.rtl,
                  ),
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.shopping_cart,
                  color: Color.fromARGB(255, 11, 75, 65),
                ),
                Text('عروض'),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 1),
                  backgroundColor: Color.fromARGB(230, 23, 182, 57),
                  content: Text(
                    'ميزة "استكشف" قيد التطوير',
                    textDirection: TextDirection.rtl,
                  ),
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.location,
                  color: Color.fromARGB(255, 11, 75, 65),
                ),
                Text('استكشف'),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 1),
                  backgroundColor: Color.fromARGB(230, 23, 182, 57),
                  content: Text(
                    'ميزة "عبادات" قيد التطوير',
                    textDirection: TextDirection.rtl,
                  ),
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.mosque_rounded,
                  color: Color.fromARGB(255, 11, 75, 65),
                ),
                Text('عبادات'),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 1),
                  backgroundColor: Color.fromARGB(230, 23, 182, 57),
                  content: Text(
                    'ميزة "الخريطة" قيد التطوير',
                    textDirection: TextDirection.rtl,
                  ),
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.gps_fixed, color: Color.fromARGB(255, 11, 75, 65)),
                Text('الخريطة'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onItemTap(PartenaireModel partenaire) {
    switch (partenaire.name) {
      case 'وكالات سياحية':
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => Agences()));
        break;
      case 'مطاعم':
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => Restaurents()));
        break;
      case 'إقامة':
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => Residence()));
        break;
      case 'عمرة':
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => Omra()));
        break;
      case 'صمم رحلتك':
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => Voyage()));
        break;
      case 'نقل':
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => Transport()));
        break;
    }
  }
}

class PartenaireModel {
  final String name;
  final String imagePath;

  PartenaireModel({required this.name, required this.imagePath});
}

List<PartenaireModel> explore = [
  PartenaireModel(name: 'دليلك السياحي', imagePath: 'Framesss.png'),
  PartenaireModel(name: 'حمامات', imagePath: 'Framess.png'),
  PartenaireModel(name: 'تسوق', imagePath: 'Passport.png'),
];

List<PartenaireModel> patrenairesmodels = [
  PartenaireModel(name: 'وكالات سياحية', imagePath: 'Vector.png'),
  PartenaireModel(name: 'إقامة', imagePath: 'Frame(1).png'),
  PartenaireModel(name: 'مطاعم', imagePath: 'Frame(2).png'),
  PartenaireModel(name: 'عمرة', imagePath: 'Frame.png'),
  PartenaireModel(name: 'صمم رحلتك', imagePath: 'Asset 9 1.png'),
  PartenaireModel(name: 'نقل', imagePath: 'SVGRepo_iconCarrier.png'),
];
