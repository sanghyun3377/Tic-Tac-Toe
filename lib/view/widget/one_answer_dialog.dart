import 'package:flutter/material.dart';

class OneAnswerDialog extends StatelessWidget {
  final Function() onTap;
  final String title;
  final String firstButton;

  const OneAnswerDialog(
      {super.key,
      required this.onTap,
      required this.title,
      required this.firstButton});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        width: 270,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
            ),
            SizedBox(height: 6),
            SizedBox(height: 16),
            SizedBox(
              width: 75,
              height: 28,
              child: ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8BC6CC)),
                  child: Text(
                    firstButton,
                  )),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
