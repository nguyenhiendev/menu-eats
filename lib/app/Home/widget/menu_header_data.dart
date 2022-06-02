import 'package:flutter/material.dart';

class MenuHeaderData extends StatelessWidget {
  const MenuHeaderData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 46),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Breakfast and Brunch · Italian · \$\$",
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
          const SizedBox(
            height: 6,
          ),
          Row(
            children: const [
              Icon(
                Icons.access_time,
                size: 14,
                color: Colors.black,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                "30-40min   4.6",
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
              SizedBox(
                width: 3,
              ),
              Icon(
                Icons.star,
                size: 14,
                color: Colors.yellow,
              ),
              SizedBox(
                width: 3,
              ),
              Text(
                "(500+)",
                style: TextStyle(fontSize: 12, color: Colors.black),
              )
            ],
          )
        ],
      ),
    );
  }
}
