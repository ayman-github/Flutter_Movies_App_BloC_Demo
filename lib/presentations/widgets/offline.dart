import 'package:flutter/material.dart';
import '../../styles/xcolors.dart';

class Offline extends StatelessWidget {
  const Offline({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Image.asset('assets/images/xoffline.gif'),
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            color: XColor.xBlack,
            child: const Text(
              'Check your internet connections',
              style: TextStyle(color: XColor.xWhite),
            ),
          ),
        ],
      ),
    );
  }
}
