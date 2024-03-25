import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/view/screen/game_board.dart';
import 'package:tic_tac_toe/view/screen/game_board_view_model.dart';
import 'package:tic_tac_toe/view/screen/login_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/GameBoard', //
      builder: (context, state) => ChangeNotifierProvider(
        create: (_) => GameBoardViewModel(),
        child: const GameBoard(),
      ),
    ),
  ],
);
