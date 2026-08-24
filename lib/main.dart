import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color borderColor = Colors.blue;
  Color backgroundColor = Colors.black;
  //int index = 0;
  //List<String?> board = List.filled(9, null);
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

  // bool isFilled() {
  //   for (int row = 0; row < 3; row++) {
  //     for (int col = 0; col < 3; col++) {
  //       if (board[row][col] != null) {
  //         count++;
  //         if (count == 9) {
  //           return;
  //         }
  //       }
  //     }
  //   }
  // }

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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(title: Text('Tic-Tac-Toe'), centerTitle: true),

      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              height: 300,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            color: backgroundColor,
                            child: Cell(
                              row: 0,
                              col: 0,
                              board: board,
                              onTap: handleTap,
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 100,
                            color: backgroundColor,
                            child: Cell(
                              row: 0,
                              col: 1,
                              board: board,
                              onTap: handleTap,
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 100,
                            color: backgroundColor,
                            child: Cell(
                              row: 0,
                              col: 2,
                              board: board,
                              onTap: handleTap,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            color: backgroundColor,
                            child: Cell(
                              row: 1,
                              col: 0,
                              board: board,
                              onTap: handleTap,
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 100,
                            color: backgroundColor,
                            child: Cell(
                              row: 1,
                              col: 1,
                              board: board,
                              onTap: handleTap,
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 100,
                            color: backgroundColor,
                            child: Cell(
                              row: 1,
                              col: 2,
                              board: board,
                              onTap: handleTap,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            color: backgroundColor,
                            child: Cell(
                              row: 2,
                              col: 0,
                              board: board,
                              onTap: handleTap,
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 100,
                            color: backgroundColor,
                            child: Cell(
                              row: 2,
                              col: 1,
                              board: board,
                              onTap: handleTap,
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 100,
                            color: backgroundColor,
                            child: Cell(
                              row: 2,
                              col: 2,
                              board: board,
                              onTap: handleTap,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  Positioned(
                    left: 95,
                    child: Container(
                      width: 10,
                      height: 300,
                      color: borderColor,
                    ),
                  ),
                  Positioned(
                    right: 95,
                    child: Container(
                      width: 10,
                      height: 300,
                      color: borderColor,
                    ),
                  ),
                  Positioned(
                    top: 95,
                    child: Container(
                      width: 300,
                      height: 10,
                      color: borderColor,
                    ),
                  ),
                  Positioned(
                    bottom: 95,
                    child: Container(
                      width: 300,
                      height: 10,
                      color: borderColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${msg}",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                if (msg == "X wins!" || msg == "O Wins!") SizedBox(width: 8),
                if (msg == "X Wins!" || msg == "O Wins!")
                  Icon(Icons.emoji_events, size: 35, color: Colors.amber),
              ],
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: resetGame,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    buttonMsg,
                    style: TextStyle(
                      fontSize: buttonMsg == "RESET" ? 30 : 15,
                      fontWeight: FontWeight.bold,
                      color: buttonMsg == "RESET" ? Colors.red : Colors.green,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    buttonMsg == "RESET" ? Icons.refresh : Icons.restart_alt,
                    size: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Cell extends StatefulWidget {
  final int row;
  final int col;
  final List<List<String?>> board;
  final Function(int, int) onTap;
  const Cell({
    super.key,
    required this.row,
    required this.col,
    required this.board,
    required this.onTap,
  });

  @override
  State<Cell> createState() => _CellState();
}

class _CellState extends State<Cell> {
  @override
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("taped");
        widget.onTap(widget.row, widget.col);
      },
      child: Container(
        width: 100,
        height: 100,
        alignment: Alignment.center,
        child: Text(
          widget.board[widget.row][widget.col] ?? '',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color:
                widget.board[widget.row][widget.col] == 'X'
                    ? Colors.white
                    : const Color.fromARGB(255, 115, 8, 216),
          ),
        ),
      ),
    );
  }
}
