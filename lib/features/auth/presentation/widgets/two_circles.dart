import 'package:flutter/material.dart';

class TwoCircles extends StatelessWidget {
  const TwoCircles({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
           Positioned(
            top: -50,
            left: -100,
            child: Opacity(
              opacity: 0.64,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFB7D5DA),
                  //color: Colors.black,
                ),
              ),
            ),
          ),
          Positioned(
            top: -100,
            left: 0,
            child: Opacity(
              opacity: 0.64,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFB7D5DA),
                  //color: Colors.black,
                ),
              ),
            ),
          ),
        ],
    );
  }
}