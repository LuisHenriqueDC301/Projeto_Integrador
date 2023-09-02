import 'dart:ffi';

import 'package:flutter/material.dart';

class Slide_Tile extends StatelessWidget {
  final String image;
  final bool activePage;
  const Slide_Tile({super.key, required this.image, required this.activePage});

  @override
  Widget build(BuildContext context) {
    final double top = this.activePage ? 50 : 150;
    final double blur = this.activePage ? 30 : 0;
    final double offset = this.activePage ? 20 : 0;

    return AnimatedContainer(
      duration: Duration(microseconds: 500),
      margin: EdgeInsets.only(
        top: top,
        bottom: 60,
        right: 15,
        left: 10,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image:
              DecorationImage(image: AssetImage(this.image), fit: BoxFit.cover),
          boxShadow: [
            BoxShadow(
                color: Colors.black87,
                blurRadius: blur,
                offset: Offset(offset, offset))
          ]),
    );
  }
}
