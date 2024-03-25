// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class GameResult extends StatelessWidget {
  final String message;
  const GameResult({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      color: Colors.black54,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 30),
      child: Text(message,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 20)),
    );
  }
}
