import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/view/screen/game_board_view_model.dart';
import 'package:tic_tac_toe/view/widget/game_message.dart';
import 'package:tic_tac_toe/game_status.dart';
import 'package:tic_tac_toe/message.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  @override
  void initState() {
    var viewModel = context.read<GameBoardViewModel>();
    viewModel.boardInit();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<GameBoardViewModel>();
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
            viewModel.playerDisplayContainer(viewModel.playerOneTurn),
            viewModel.gameGridBoard(context),
            Visibility(
              visible: viewModel.gameStatus != GameStatus.play,
              child: viewModel.menuButton(context),
            ),
            Visibility(
              visible: viewModel.gameStatus == GameStatus.play,
              child: GameMessage(
                message: viewModel.playerOneTurn
                    ? Message.playerOneTurn
                    : Message.playerTwoTurn,
              ),
            )
          ]),
        ),
      ),
    );
  }
}
