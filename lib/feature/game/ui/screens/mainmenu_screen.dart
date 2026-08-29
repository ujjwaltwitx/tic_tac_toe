// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:tic_tac_toe/feature/game/domain/game_board_engine.dart';
// import 'package:tic_tac_toe/feature/game/ui/widgets/game_board_widget.dart';
// import 'package:tic_tac_toe/shared/custom_theme_data.dart';
import 'package:tic_tac_toe/shared/custom_theme_data.dart';
import 'package:tic_tac_toe/shared/widgets/navbar_widget.dart';

import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(top: 50),

        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(top: 0, child: _topBar()),

            Positioned(
              top: 80,
              child: SizedBox(height: 386, width: 185, child: tic_toe_logo()),
            ),

            Positioned(
              top: 450,
              child: Column(
                children: [
                  Container(
                    height: 59,
                    width: 342,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff162839)),
                    ),
                    child: PlayVSCPU(),
                  ),

                  SizedBox(height: 15),

                  Container(
                    height: 59,
                    width: 342,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff162839)),
                    ),
                    child: PlaywithFriend(),
                  ),
                ],
              ),
            ),

            Positioned(bottom: 50, child: CustomNavigationBar()),
          ],
        ),
      ),
    );
  }

  Positioned PlayVSCPU() {
    return Positioned(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(onPressed: () {}, icon: Icon(Icons.directions_boat)),
          Text(
            "PLAY VS CPU",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.normal,
              fontFamily: CustomThemeData.fontFamilyBricolage,
              color: Color(0xff162839),
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }

  Positioned PlaywithFriend() {
    return Positioned(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(onPressed: () {}, icon: Icon(Icons.people)),
          Text(
            "PLAY VS FRIEND",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.normal,
              fontFamily: CustomThemeData.fontFamilyBricolage,
              color: Color(0xff162839),
            ),
          ),
          SizedBox(width: 10),
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
}

class tic_toe_logo extends StatelessWidget {
  const tic_toe_logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "TIC",
          style: TextStyle(
            fontSize: 84,
            fontWeight: FontWeight.normal,
            fontFamily: CustomThemeData.fontFamilyBricolage,
            color: Color(0xff162839),
          ),
        ),
        Text(
          "TAC",
          style: TextStyle(
            fontSize: 84,
            fontWeight: FontWeight.normal,
            fontFamily: CustomThemeData.fontFamilyBricolage,
            color: Color(0xff162839),
          ),
        ),
        Text(
          "TOE",
          style: TextStyle(
            fontSize: 84,
            fontWeight: FontWeight.normal,
            fontFamily: CustomThemeData.fontFamilyBricolage,
            color: Color(0xff162839),
          ),
        ),
      ],
    );
  }
}
