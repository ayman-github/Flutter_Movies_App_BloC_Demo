import 'package:flutter/material.dart';
import '../../styles/xtext.dart';
import '../../styles/xcolors.dart';

class MovieDetails extends StatelessWidget {
  final String title;
  final String description;

  const MovieDetails({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(title, style: titleStyle),
        ),
        const SizedBox(height: 10),
        Align(
            alignment: Alignment.topLeft,
            child: Text(description, style: descriptionStyle)),
        const Divider(
          height: 30,
          color: XColor.xGrey,
          thickness: 0.5,
        ),
      ],
    );
  }
}
