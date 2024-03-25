// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class PlayerOneDisplay extends StatelessWidget {
  final bool isMyTurn;
  const PlayerOneDisplay({
    Key? key,
    required this.isMyTurn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Text(
        isMyTurn ? "Player 1 (O) 차례" : "Player 1 (O)",
        style: TextStyle(
          fontSize: 18,
          color: isMyTurn ? Colors.amberAccent : Colors.white,
          fontWeight: isMyTurn ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
