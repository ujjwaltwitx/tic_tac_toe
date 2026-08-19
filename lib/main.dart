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

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          height: 300,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        color: backgroundColor,
                        child: Cell(),
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        color: backgroundColor,
                        child: Cell(),
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        color: backgroundColor,
                        child: Cell(shouldShowCross: true),
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
                        child: Cell(),
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        color: backgroundColor,
                        child: Cell(),
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        color: backgroundColor,
                        child: Cell(),
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
                        child: Cell(),
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        color: backgroundColor,
                        child: Cell(),
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        color: backgroundColor,
                        child: Cell(),
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                left: 95,
                child: Container(width: 10, height: 300, color: borderColor),
              ),
              Positioned(
                right: 95,
                child: Container(width: 10, height: 300, color: borderColor),
              ),
              Positioned(
                top: 95,
                child: Container(width: 300, height: 10, color: borderColor),
              ),
              Positioned(
                bottom: 95,
                child: Container(width: 300, height: 10, color: borderColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Cell extends StatefulWidget {
  bool shouldShowCross = false;
  Cell({this.shouldShowCross = false});

  @override
  State<Cell> createState() => _CellState();
}

class _CellState extends State<Cell> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.shouldShowCross = !widget.shouldShowCross;
        });
      },
      child: Container(
        width: 100,
        height: 100,
        alignment: Alignment.center,
        child: Text(
          widget.shouldShowCross ? 'X' : 'O',
          style: TextStyle(color: Colors.white, fontSize: 40),
        ),
      ),
    );
  }
}
