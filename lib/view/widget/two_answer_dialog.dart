import 'package:flutter/material.dart';

class TwoAnswerDialog extends StatelessWidget {
  final Function() onTap;
  final Function() onPressed;
  final String title;
  final String nickname;
  final String firstButton;
  final String secoundButton;

  const TwoAnswerDialog(
      {super.key,
      required this.onTap,
      required this.title,
      required this.firstButton,
      required this.nickname,
      required this.onPressed,
      required this.secoundButton});

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
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: onPressed,
                    style: ButtonStyle(
                        // 버튼크기조절
                        minimumSize:
                            MaterialStateProperty.all(const Size(48, 40)),
                        //테두리 모양 조절
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.red[400])),
                    child: Text(
                      firstButton,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                const SizedBox(width: 8),
                ElevatedButton(
                    onPressed: onTap,
                    style: ButtonStyle(
                        // 버튼크기조절
                        minimumSize:
                            MaterialStateProperty.all(const Size(48, 40)),
                        //테두리 모양 조절
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue[400])),
                    child: Text(
                      secoundButton,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
