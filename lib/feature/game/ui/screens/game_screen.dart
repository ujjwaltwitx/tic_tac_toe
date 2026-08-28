import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/feature/game/domain/game_board_engine.dart';
import 'package:tic_tac_toe/feature/game/ui/widgets/game_board_widget.dart';
import 'package:tic_tac_toe/shared/custom_theme_data.dart';
import 'package:tic_tac_toe/shared/widgets/navbar_widget.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(top: 50),
        // color: Colors.blue,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // top bar
            Positioned(top: 0, child: _topBar()),

            // round info
            Positioned(top: 80, child: _roundInfo()),

            // player info
            Positioned(top: 134, child: _playersInfo()),

            // game board
            Positioned(
              top: 250,
              child: GameBoardWidget(gameBoardEngine: GameBoardEngine()),
            ),

            // new game button
            Positioned(
              top: 610,
              child: InkWell(
                onTap: () {},
                child: Transform.rotate(
                  angle: 1 * pi / 180,
                  child: Container(
                    width: 128,
                    height: 52,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff162839), width: 2),
                    ),
                    child: Text(
                      "New Game",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: CustomThemeData.fontFamilyKarla,
                        color: Color(0xffb02d21),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // bottom navigation bar
            Positioned(bottom: 50, child: CustomNavigationBar()),
          ],
        ),
      ),
    );
  }

  Widget _playersInfo() {
    return SizedBox(
      width: 342,
      height: 48,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Player (X)",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: CustomThemeData.fontFamilyKarla,
                  color: Color(0xff43474c),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    3,
                    (index) => _buildCircleIndicator(),
                  ).toList(),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "CPU (O)",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: CustomThemeData.fontFamilyKarla,
                  color: Color(0xff43474c),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    2,
                    (index) => _buildCircleIndicator(),
                  ).toList(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _roundInfo() {
    return Container(
      height: 34,
      width: 342,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xff162839), width: 2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "X's Turn",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              fontFamily: CustomThemeData.fontFamilyBricolage,
              color: Color(0xff162839),
            ),
          ),
          Text(
            "Round 1",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: CustomThemeData.fontFamilyKarla,
              color: Color(0xff43474c),
            ),
          ),
        ],
      ),
    );
  }

  Widget _topBar() {
    return Container(
      width: 390,
      height: 48,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xff162839), width: 2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
          Text(
            "Tic Tac Toe",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              fontFamily: CustomThemeData.fontFamilyBricolage,
              color: Color(0xff162839),
            ),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
        ],
      ),
    );
  }

  Widget _buildCircleIndicator() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2),
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xff43474c),
      ),
    );
  }
}
