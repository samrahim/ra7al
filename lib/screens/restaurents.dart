import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ra7al/screens/agences.dart';
import 'package:ra7al/widgets/widgets.dart';

class Restaurents extends StatefulWidget {
  const Restaurents({super.key});

  @override
  State<Restaurents> createState() => _RestaurentsState();
}

class _RestaurentsState extends State<Restaurents> {
  String? selectedWilaya;
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: 38,
                          width: 38,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(CupertinoIcons.back, color: Colors.green),
                        ),
                      ),
                      Text(
                        'عروض المطاعم',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 40),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  child: Directionality(
                    textDirection: TextDirection.rtl,

                    child: SearchBar(
                      leading: Icon(Icons.search),
                      hintText: 'ابحث عن أفضل المطاعم',

                      backgroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                  ),
                ),

                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 2),
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButton<String>(
                        hint: Text(
                          "اختر الولاية",
                          style: TextStyle(
                            color: Color.fromARGB(255, 11, 75, 65),
                            fontSize: 16,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        value: selectedWilaya,

                        underline: SizedBox(),
                        icon: Icon(Icons.arrow_drop_down, color: Colors.green),
                        dropdownColor: Colors.white,
                        style: TextStyle(
                          color: Color.fromARGB(255, 11, 75, 65),
                          fontSize: 16,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        items:
                            wilayas.map<DropdownMenuItem<String>>((
                              String value,
                            ) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedWilaya = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 4, bottom: 4),
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: EdgeInsets.all(8),
                    child: ListView.builder(
                      itemCount:
                          restaurents
                              .where(
                                (residence) =>
                                    selectedWilaya == null ||
                                    residence.wilaya == selectedWilaya,
                              )
                              .length,

                      itemBuilder: (context, ind) {
                        final filteredrestaurents =
                            restaurents
                                .where(
                                  (restaurent) =>
                                      selectedWilaya == null ||
                                      restaurent.wilaya == selectedWilaya,
                                )
                                .toList();
                        return Container(
                          margin: EdgeInsets.only(bottom: 8, left: 8, right: 8),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.green, width: 1.6),
                          ),
                          height: MediaQuery.of(context).size.height * .16,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                CupertinoIcons.back,
                                color: Color.fromARGB(255, 11, 75, 65),
                              ),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        filteredrestaurents[ind].name,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromARGB(
                                            255,
                                            11,
                                            75,
                                            65,
                                          ),
                                        ),
                                      ),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.star, color: Colors.amber),
                                          Text(
                                            filteredrestaurents[ind].rating
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  SizedBox(width: 16),
                                  Image.asset(
                                    filteredrestaurents[ind].imagePath,
                                    height:
                                        MediaQuery.of(context).size.height *
                                        .16,
                                    fit: BoxFit.cover,
                                    width:
                                        MediaQuery.of(context).size.width * .3,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
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

class RestaurentModel {
  final String name;
  final double rating;
  final String imagePath;
  final String wilaya;
  RestaurentModel({
    required this.wilaya,

    required this.name,
    required this.rating,
    required this.imagePath,
  });
}

List<RestaurentModel> restaurents = [
  RestaurentModel(
    wilaya: 'باتنة',
    name: 'La perla nera',
    rating: 4.7,
    imagePath: 'assets/la_perla.jpeg',
  ),
  RestaurentModel(
    wilaya: 'الجزائر',
    name: 'Farfalla',
    rating: 4.7,
    imagePath: 'assets/farfalla.jpg',
  ),
  RestaurentModel(
    wilaya: 'عنابة',
    name: 'Donterlla',
    rating: 4.7,
    imagePath: 'assets/dontella.jpeg',
  ),
];
