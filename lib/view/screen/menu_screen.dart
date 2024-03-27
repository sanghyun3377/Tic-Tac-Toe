import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tic_tac_toe/view/widget/circular_graph_widget.dart';
import 'package:tic_tac_toe/view/widget/play_button.dart';
import 'package:tic_tac_toe/view/widget/score_text.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Colors.blue[400] as Color,
            Colors.blue[600] as Color,
            Colors.blue[800] as Color
          ])),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: PlayButton(
                      buttonName: '오프라인\n2인게임',
                      icon: Icons.people_alt,
                      onPressed: () {
                        context.push('/GameBoard');
                      },
                    )),
                    const SizedBox(width: 8),
                    Expanded(
                        child: PlayButton(
                      buttonName: '온라인\n자동게임',
                      icon: Icons.wifi,
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      },
                    )),
                  ],
                ),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            colors: [
                              Colors.white38,
                              Colors.white54,
                              Colors.white60
                            ]),
                        borderRadius: BorderRadius.circular(8)),
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        const Text(
                          ' 반갑습니다!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 32),
                        const WinLossDrawCircularGraph(
                          graphName: 'Total : 123판',
                          winCount: 30,
                          drawCount: 4,
                          lossCount: 50,
                          radius: 40,
                        ),
                        const SizedBox(height: 16),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ScoreText(
                                scoreName: '승리',
                                score: '3판(12%)',
                                color: Colors.red,
                              ),
                              ScoreText(
                                scoreName: '무승부',
                                score: '51판(73%)',
                                color: Colors.green[800] as Color,
                              ),
                              ScoreText(
                                scoreName: '패배',
                                score: '32판(23%)',
                                color: Colors.blue[800] as Color,
                              ),
                            ])
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
