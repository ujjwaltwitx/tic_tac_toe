import 'package:flutter/material.dart';
import 'package:tic_tac_toe/feature/game/ui/screens/landing_screen.dart';
import 'package:tic_tac_toe/feature/game/ui/screens/games_history_screen.dart';

import 'feature/game/ui/screens/game_over_screen.dart';
import 'feature/game/ui/screens/game_screen.dart';
import 'shared/utilities/positioning.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Positioning.init(context);
    return MaterialApp(
      title: 'Tic Tac Toe',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (_) => const LandingScreen(),
        '/game': (_) => const GameScreen(),
        '/history': (_) => GamesHistoryScreen(),
      },
      theme: ThemeData(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<List<String?>> board = List.generate(3, (_) => List.filled(3, null));
  bool shouldShowCross = true;
  bool gameOver = false;
  String msg = "X Turn";
  int count = 0;
  String buttonMsg = "RESET";
  void handleTap(int row, int col) {
    if (gameOver) {
      return;
    }
    if (board[row][col] != null) {
      return;
    }
    setState(() {
      board[row][col] = shouldShowCross ? "X" : "O";
      count++;
    });
    if (checkWinner()) {
      print("${shouldShowCross ? "X" : "O"} wins!");
      setState(() {
        gameOver = true;
        msg = "${shouldShowCross ? "X" : "O"} Wins!";
        buttonMsg = "PLAY AGAIN!";
        resetGame();
      });
      return;
    }
    if (count == 9) {
      resetGame();
    }

    setState(() {
      shouldShowCross = !shouldShowCross;
      msg = shouldShowCross ? "X Turn" : "O Turn";
      buttonMsg = "RESET";
    });
  }

  void resetGame() {
    setState(() {
      board = List.generate(3, (_) => List.filled(3, null));
    });
    shouldShowCross = true;
    gameOver = false;
    // msg = "X Turn";
    //buttonMsg = "RESET";
    count = 0;
  }

  bool checkWinner() {
    for (int row = 0; row < 3; row++) {
      if (board[row][0] != null &&
          board[row][0] == board[row][1] &&
          board[row][1] == board[row][2]) {
        return true;
      }
    }
    for (int col = 0; col < 3; col++) {
      if (board[0][col] != null &&
          board[0][col] == board[1][col] &&
          board[1][col] == board[2][col]) {
        return true;
      }
    }
    for (int row = 0; row < 3; row++) {
      if (board[0][0] != null &&
          board[0][0] == board[1][1] &&
          board[1][1] == board[2][2]) {
        return true;
      }
    }

    for (int row = 0; row < 3; row++) {
      if (board[0][2] != null &&
          board[0][2] == board[1][1] &&
          board[1][1] == board[2][0]) {
        return true;
      }
    }
    return false;
    // we  are left with diagonal check
  }

  @override
  Widget build(BuildContext context) {
    return GameOverScreen();
  }
}
