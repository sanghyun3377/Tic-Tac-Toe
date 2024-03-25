import 'dart:io';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/view/screen/game_board_view_model.dart';
import 'package:tic_tac_toe/view/widget/game_message.dart';
import 'package:tic_tac_toe/view/widget/game_result.dart';
import 'package:tic_tac_toe/game_status.dart';
import 'package:tic_tac_toe/view/widget/game_title.dart';
import 'package:tic_tac_toe/message.dart';
import 'package:tic_tac_toe/view/widget/player1.dart';
import 'package:tic_tac_toe/view/widget/player2.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  late List<List<String>> board;
  bool _playerOneTurn = false;
  GameStatus _gameStatus = GameStatus.start;

  @override
  void initState() {
    boardInit();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void boardInit() {
    board = List.generate(
        3, (index) => List.generate(3, (i) => "", growable: false));
  }

  void gameCheck() {
    int boardCount = 0;
    // 대각선 체크
    if ((board[0][0] == "O" && board[1][1] == "O" && board[2][2] == "O") ||
        (board[0][2] == "O" && board[1][1] == "O" && board[2][0] == "O")) {
      _gameStatus = GameStatus.playerOneWin;
    } else if ((board[0][0] == "X" &&
            board[1][1] == "X" &&
            board[2][2] == "X") ||
        (board[0][2] == "X" && board[1][1] == "X" && board[2][0] == "X")) {
      _gameStatus = GameStatus.playerTwoWin;
    }

    // 가로세로 체크
    for (var i = 0; i < 3; i++) {
      if ((board[i][0] == "O" && board[i][1] == "0" && board[i][2] == "O") ||
          ((board[0][i]) == "O" && board[1][i] == "O" && board[2][i] == "O")) {
        _gameStatus = GameStatus.playerOneWin;
      } else if ((board[i][0] == "X" &&
              board[i][1] == "X" &&
              board[i][2] == "X") ||
          (board[0][i] == "X" && board[1][i] == "X" && board[2][i] == "X")) {
        _gameStatus = GameStatus.playerTwoWin;
      }
      for (var j = 0; j < 3; j++) {
        if (board[i][j] != "") boardCount++;
      }
    }

    // 무승부 체크
    if (boardCount >= 9 &&
        _gameStatus != GameStatus.playerOneWin &&
        _gameStatus != GameStatus.playerTwoWin) {
      _gameStatus = GameStatus.draw;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ViewModel = context.watch<GameBoardViewModel>();
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
          child: Stack(children: [
            playerDisplayContainer(_playerOneTurn),
            gameGridBoard(),
            Visibility(
              visible: _gameStatus != GameStatus.play,
              child: menuButton(),
            ),
            Visibility(
              visible: _gameStatus == GameStatus.play,
              child: GameMessage(
                message: _playerOneTurn
                    ? Message.playerOneTurn
                    : Message.playerTwoTurn,
              ),
            )
          ]),
        ),
      ),
    );
  }

  Widget gameGridBoard() {
    late List<Widget> boxes = [];
    for (var i = 1; i <= 3; i++) {
      for (var j = 1; j <= 3; j++) {
        boxes.add(boardBox(i, j, mark: board[i - 1][j - 1]));
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

  Widget boardBox(int x, int y, {String mark = ""}) {
    return GestureDetector(
      onTap: () {
        if (board[x - 1][y - 1] == "") {
          setState(() {
            _playerOneTurn
                ? board[x - 1][y - 1] = "O"
                : board[x - 1][y - 1] = "X";
          });
          _playerOneTurn = !_playerOneTurn;
          gameCheck();
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("비어 있는 곳만 표시가능합니다.")));
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

  Widget menuButton() {
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
          if (_gameStatus == GameStatus.playerOneWin)
            GameResult(message: Message.playerOneWin)
          else if (_gameStatus == GameStatus.playerTwoWin)
            GameResult(message: Message.playerTwoWin)
          else if (_gameStatus == GameStatus.draw)
            GameResult(message: Message.gameIsDraw),
          playerMenuButton(),
          const SizedBox(height: 15),
          exitMenuButton(),
        ],
      ),
    );
  }

  Widget playerMenuButton() {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            _gameStatus = GameStatus.play;
            boardInit();
            int whoPlaysFirst = Random().nextInt(2);
            _playerOneTurn = whoPlaysFirst == 0 ? true : false;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          child: const Text(
            "게임 시작",
            style: TextStyle(fontSize: 22),
          ),
        ));
  }

  Widget exitMenuButton() {
    return ElevatedButton(
        onPressed: () {
          if (Platform.isAndroid) {
            SystemNavigator.pop();
          } else if (Platform.isIOS) {
            exit(0);
          } else {
            Navigator.of(context).pop();
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          child: const Text(
            "게임 종료",
            style: TextStyle(fontSize: 22),
          ),
        ));
  }
}
