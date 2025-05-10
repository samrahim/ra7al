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
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "عروض موصى بها",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  width: MediaQuery.of(context).size.width * 0.47,
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * .13,
                  'assets/image.png',
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  width: MediaQuery.of(context).size.width * 0.47,
                  "assets/Recommended.png",

                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * .13,
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
