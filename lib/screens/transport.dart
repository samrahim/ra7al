import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ra7al/widgets/custom_appbar.dart';
import 'package:ra7al/widgets/text_field.dart';

class Transport extends StatelessWidget {
  const Transport({super.key});

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
                        'عروض الوكالات السياحية',
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
                      hintText: 'ابحث عن أفضل عروض النقل',
                      onSubmitted: (query) {
                        if (query.isNotEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: Duration(seconds: 1),
                              backgroundColor: Color.fromARGB(230, 23, 182, 57),
                              content: Text(
                                'بحث عن: $query (الميزة قيد التطوير)',
                                textDirection: TextDirection.rtl,
                              ),
                            ),
                          );
                        }
                      },
                      backgroundColor: MaterialStateProperty.all(Colors.white),
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
                    child: Center(child: Text('سيتم اضافة العروض قريبا')),
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
