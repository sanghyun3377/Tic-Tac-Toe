import 'package:flutter/material.dart';

class ScoreText extends StatelessWidget {
  final String scoreName;
  final String score;
  final Color color;
  const ScoreText(
      {super.key,
      required this.scoreName,
      required this.score,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          scoreName,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        Text(
          score,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: color),
        ),
      ],
    );
  }
}
