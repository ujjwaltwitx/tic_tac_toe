import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/feature/game/domain/game_board_engine.dart';
import 'package:tic_tac_toe/feature/game/ui/widgets/game_board_widget.dart';
import 'package:tic_tac_toe/shared/custom_theme_data.dart';
import 'package:tic_tac_toe/shared/widgets/navbar_widget.dart';

import '../../../../shared/utilities/positioning.dart';
import '../../../../shared/widgets/top_bar_widget.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(top: Positioning.safeAreaPaddingTop),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // top bar
            Positioned(top: 0, child: TopBarWidget()),

            // round info
            Positioned(
              top: Positioning.getActualDeviceHeight(80),
              child: _roundInfo(),
            ),

            // player info
            Positioned(
              top: Positioning.getActualDeviceHeight(134),
              child: _playersInfo(),
            ),

            // game board
            Positioned(
              top: Positioning.getActualDeviceHeight(250),
              child: GameBoardWidget(gameBoardEngine: GameBoardEngine()),
            ),

            // new game button
            Positioned(
              top: Positioning.getActualDeviceHeight(610),
              child: InkWell(
                onTap: () {},
                child: Transform.rotate(
                  angle: 1 * pi / 180,
                  child: Container(
                    width: Positioning.getActualDeviceWidth(128),
                    height: Positioning.getActualDeviceHeight(52),
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
            Positioned(
              bottom: Positioning.safeAreaPaddingBottom,
              child: CustomNavigationBar(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _playersInfo() {
    return SizedBox(
      width: Positioning.getActualDeviceWidth(342),
      height: Positioning.getActualDeviceHeight(48),
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
      height: Positioning.getActualDeviceHeight(34),
      width: Positioning.getActualDeviceWidth(342),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xff162839),
            width: Positioning.getAssetSize(2),
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "X's Turn",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: CustomThemeData.fontFamilyKarla,
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

  Widget _buildCircleIndicator() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2),
      height: Positioning.getAssetSize(10),
      width: Positioning.getAssetSize(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xff43474c),
      ),
    );
  }
}
