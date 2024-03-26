import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tic_tac_toe/game_status.dart';
import 'package:tic_tac_toe/message.dart';
import 'package:tic_tac_toe/view/widget/game_result.dart';
import 'package:tic_tac_toe/view/widget/game_title.dart';
import 'package:tic_tac_toe/view/widget/player1.dart';
import 'package:tic_tac_toe/view/widget/player2.dart';

class GameBoardViewModel with ChangeNotifier {
  late List<List<String>> board;
  bool playerOneTurn = false;
  GameStatus gameStatus = GameStatus.start;

  void boardInit() {
    board = List.generate(
        3, (index) => List.generate(3, (i) => "", growable: false));
  }

  void gameCheck() {
    int boardCount = 0;
    // 대각선 체크
    if ((board[0][0] == "O" && board[1][1] == "O" && board[2][2] == "O") ||
        (board[0][2] == "O" && board[1][1] == "O" && board[2][0] == "O")) {
      gameStatus = GameStatus.playerOneWin;
    } else if ((board[0][0] == "X" &&
            board[1][1] == "X" &&
            board[2][2] == "X") ||
        (board[0][2] == "X" && board[1][1] == "X" && board[2][0] == "X")) {
      gameStatus = GameStatus.playerTwoWin;
    }

    // 가로세로 체크
    for (var i = 0; i < 3; i++) {
      if ((board[i][0] == "O" && board[i][1] == "O" && board[i][2] == "O") ||
          ((board[0][i]) == "O" && board[1][i] == "O" && board[2][i] == "O")) {
        gameStatus = GameStatus.playerOneWin;
      } else if ((board[i][0] == "X" &&
              board[i][1] == "X" &&
              board[i][2] == "X") ||
          (board[0][i] == "X" && board[1][i] == "X" && board[2][i] == "X")) {
        gameStatus = GameStatus.playerTwoWin;
      }
      for (var j = 0; j < 3; j++) {
        if (board[i][j] != "") boardCount++;
      }
    }

    // 무승부 체크
    if (boardCount >= 9 &&
        gameStatus != GameStatus.playerOneWin &&
        gameStatus != GameStatus.playerTwoWin) {
      gameStatus = GameStatus.draw;
    }
  }

  Widget gameGridBoard(BuildContext context) {
    late List<Widget> boxes = [];
    for (var i = 1; i <= 3; i++) {
      for (var j = 1; j <= 3; j++) {
        boxes.add(boardBox(i, j, context, mark: board[i - 1][j - 1]));
      }
    }
    return Center(
      child: GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          children: boxes),
    );
  }

  Widget boardBox(int x, int y, BuildContext context, {String mark = ""}) {
    return GestureDetector(
      onTap: () {
        if (board[x - 1][y - 1] == "") {
          playerOneTurn ? board[x - 1][y - 1] = "O" : board[x - 1][y - 1] = "X";
          notifyListeners();
          playerOneTurn = !playerOneTurn;
          gameCheck();
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("비어 있는 곳만 터치가능합니다.")));
        }
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        color: Colors.white70,
        alignment: Alignment.center,
        child: Text(
          mark,
          style: const TextStyle(fontSize: 48),
        ),
      ),
    );
  }

  Widget menuButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black.withOpacity(0.5),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const GameTitle(),
          const SizedBox(height: 40),
          if (gameStatus == GameStatus.playerOneWin)
            GameResult(message: Message.playerOneWin)
          else if (gameStatus == GameStatus.playerTwoWin)
            GameResult(message: Message.playerTwoWin)
          else if (gameStatus == GameStatus.draw)
            GameResult(message: Message.gameIsDraw),
          playerMenuButton(),
          const SizedBox(height: 15),
          exitMenuButton(context),
        ],
      ),
    );
  }

  Widget playerMenuButton() {
    return ElevatedButton(
        onPressed: () {
          gameStatus = GameStatus.play;
          boardInit();
          int whoPlaysFirst = Random().nextInt(2);
          playerOneTurn = whoPlaysFirst == 0 ? true : false;
          notifyListeners();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          child: const Text(
            "게임 시작",
            style: TextStyle(fontSize: 22),
          ),
        ));
  }

  Widget exitMenuButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          context.pop();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          child: const Text(
            "돌아가기",
            style: TextStyle(fontSize: 22),
          ),
        ));
  }

  Widget playerDisplayContainer(bool isPlayerOneTurn) {
    return Container(
      margin: const EdgeInsets.only(top: 70),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PlayerOneDisplay(isMyTurn: isPlayerOneTurn),
          PlayerTwoDisplay(isMyTurn: !isPlayerOneTurn)
        ],
      ),
    );
  }
}
