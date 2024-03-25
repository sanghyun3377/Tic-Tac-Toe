// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class GameMessage extends StatelessWidget {
  final String message;
  const GameMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 30),
      child: Text(message,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 16)),
    );
  }
}
