import 'package:flutter/material.dart';

class PlayerTwoDisplay extends StatelessWidget {
  final bool isMyTurn;
  const PlayerTwoDisplay({
    Key? key,
    required this.isMyTurn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Text(
        isMyTurn ? "Player 2 (X) 차례" : "Player 2 (X)",
        style: TextStyle(
          fontSize: 18,
          color: isMyTurn ? Colors.amberAccent : Colors.white,
          fontWeight: isMyTurn ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
