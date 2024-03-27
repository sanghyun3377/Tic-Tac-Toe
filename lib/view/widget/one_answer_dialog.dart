import 'package:flutter/material.dart';

class OneAnswerDialog extends StatelessWidget {
  final Function() onTap;
  final String title;
  final String nickname;
  final String firstButton;

  const OneAnswerDialog(
      {super.key,
      required this.onTap,
      required this.title,
      required this.firstButton,
      required this.nickname});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Text(
              '"$nickname"',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            ElevatedButton(
                onPressed: onTap,
                style: ButtonStyle(
                    // 버튼크기조절
                    minimumSize: MaterialStateProperty.all(const Size(48, 32)),
                    //테두리 모양 조절
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.blue[400])),
                child: Text(
                  firstButton,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
}
