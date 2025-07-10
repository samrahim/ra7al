import 'package:flutter/material.dart';

class Suggestion extends StatelessWidget {
  const Suggestion({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Text(
              "عروض موصى بها",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(seconds: 1),
                      backgroundColor: Color.fromARGB(230, 23, 182, 57),
                      content: Text(
                        'قيد التطوير',
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    width: MediaQuery.of(context).size.width * 0.47,
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height * .13,
                    'assets/image.png',
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(seconds: 1),
                      backgroundColor: Color.fromARGB(230, 23, 182, 57),
                      content: Text(
                        'قيد التطوير',
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    width: MediaQuery.of(context).size.width * 0.47,
                    "assets/Recommended.png",

                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height * .13,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
        ],
      ),
    );
  }
}
