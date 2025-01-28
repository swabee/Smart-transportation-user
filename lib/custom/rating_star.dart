import 'package:flutter/material.dart';



class RatingStar extends StatelessWidget {
  const RatingStar({
    super.key,
    required this.rating,
    this.starsize,
    this.frameColor,
    this.color = Colors.orangeAccent,
    this.margin,
  });
  final double rating;
  final double? starsize;
  final Color? color;
  final Color? frameColor;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    int fullstars = rating.floor();
    // double halfstars = rating - fullstars;
    return Container(
      margin: margin,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(5, (index) {
          if (index < fullstars) {
            return ImageIcon(
              const AssetImage('assets/icons/star-filled.png'),
              size: starsize ?? 20,
              color: color,
            );
          } else {
            return ImageIcon(
              const AssetImage('assets/icons/star.png'),
              size: starsize ?? 20,
              color: color,
            );
          }
        }),
      ),
    );
  }
}
