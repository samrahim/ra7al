import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ra7al/screens/agences.dart';
import 'package:ra7al/widgets/widgets.dart';

class Residence extends StatefulWidget {
  const Residence({super.key});

  @override
  State<Residence> createState() => _ResidenceState();
}

class _ResidenceState extends State<Residence> {
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
                        'عروض الإقامة',
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
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: CustomTextFormField(
                    suffixIcon: Icons.search,
                    controller: TextEditingController(),
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.ltr,
                    hintText: 'ابحث عن مكان اقامتك',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
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
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.green,
                          ),
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
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
                          value: 'فندق',
                          underline: SizedBox(),
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.green,
                          ),
                          dropdownColor: Colors.white,
                          style: TextStyle(
                            color: Color.fromARGB(255, 11, 75, 65),
                            fontSize: 16,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          items: [
                            DropdownMenuItem<String>(
                              value: 'فندق',
                              child: Text(
                                'فندق',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                          onChanged: (String? newValue) {},
                        ),
                      ),
                    ),
                  ],
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
                          residences
                              .where(
                                (residence) =>
                                    selectedWilaya == null ||
                                    residence.wilaya == selectedWilaya,
                              )
                              .length,

                      itemBuilder: (context, ind) {
                        final filteredResicences =
                            residences
                                .where(
                                  (residence) =>
                                      selectedWilaya == null ||
                                      residence.wilaya == selectedWilaya,
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
                                        filteredResicences[ind].name,
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
                                            filteredResicences[ind].rating
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  SizedBox(width: 16),
                                  Image.asset(
                                    filteredResicences[ind].imagePath,
                                    height:
                                        MediaQuery.of(context).size.height *
                                        .16,
                                    fit: BoxFit.cover,
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

class ResidenceModel {
  final String type;
  final String wilaya;
  final String name;
  final String imagePath;
  final double rating;

  ResidenceModel({
    required this.rating,
    required this.type,
    required this.wilaya,
    required this.name,
    required this.imagePath,
  });
}

List<ResidenceModel> residences = [
  ResidenceModel(
    type: 'فندق',
    wilaya: wilayas[0],
    name: 'Ibis Hotel',
    imagePath: 'assets/ibis.png',
    rating: 4,
  ),

  ResidenceModel(
    type: 'فندق',
    wilaya: wilayas[1],
    name: 'Park mall Hotel',
    imagePath: 'assets/park_mall.png',
    rating: 4,
  ),

  ResidenceModel(
    type: 'فندق',
    wilaya: wilayas[3],
    name: 'Golden Ocean Hotel',
    imagePath: 'assets/golden_ocean.png',
    rating: 3,
  ),

  ResidenceModel(
    type: 'فندق',
    wilaya: 'الجزائر',
    name: 'Ibis Hotel',
    imagePath: 'assets/ibis.png',
    rating: 2,
  ),

  ResidenceModel(
    type: 'فندق',
    wilaya: wilayas[2],
    name: 'Golden Tulip Hotel',
    imagePath: 'assets/golden.png',
    rating: 3,
  ),

  ResidenceModel(
    type: 'فندق',
    wilaya: wilayas[4],
    name: 'Hammamat Hotel',
    imagePath: 'assets/hammamat.png',
    rating: 3,
  ),
];
