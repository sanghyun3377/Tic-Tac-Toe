import 'package:flutter/material.dart';

class PlayButton extends StatelessWidget {
  final String buttonName;
  final IconData icon;
  final Function() onPressed;
  const PlayButton(
      {super.key,
      required this.buttonName,
      required this.icon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          minimumSize:
              const MaterialStatePropertyAll(Size(double.infinity, 70)),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          backgroundColor: MaterialStateProperty.all(Colors.white70)),
      child: Row(
        children: [
          Icon(
            icon,
            size: 48,
            color: Colors.blue,
          ),
          const SizedBox(width: 4),
          Text(
            textAlign: TextAlign.center,
            buttonName,
            style: const TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
