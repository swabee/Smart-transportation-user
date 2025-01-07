import 'package:flutter/material.dart';

class IconCard extends StatelessWidget {
  final IconData iconData;
  final String text;

  const IconCard({super.key, required this.iconData, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Column(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: IconButton(
                icon: Icon(
                  iconData,
                  size: 30,
                  color: Colors.red,
                ),
                onPressed: () {},
              )),
          Text(
            text,
            style: const TextStyle(fontSize: 10),
          )
        ],
      ),
    );
  }
}
