import 'package:tic_tac_toe/feature/game/domain/game_mode.dart';
import 'package:tic_tac_toe/shared/custom_theme_data.dart';
import 'package:tic_tac_toe/shared/widgets/navbar_widget.dart';

import 'package:flutter/material.dart';

import '../../../../shared/utilities/positioning.dart';
import '../../../../shared/widgets/top_bar_widget.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Positioning.screenWidth,
        height: Positioning.screenHeight,
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage(
        //       GameUtil.getAssetPath(GameConstants.backgroundImage),
        //     ),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              child: Container(
                width: Positioning.getActualDeviceWidth(390),
                height: Positioning.getActualDeviceHeight(390),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.04),
                ),
              ),
            ),
            Positioned(
              top: Positioning.safeAreaPaddingTop,
              child: TopBarWidget(),
            ),
            Positioned(
              top: Positioning.getActualDeviceHeight(164),
              child: SizedBox(
                height: Positioning.getActualDeviceHeight(386),
                width: Positioning.getActualDeviceWidth(185),
                child: TicTacLogo(),
              ),
            ),

            Positioned(
              top: Positioning.getActualDeviceHeight(498),
              child: customButton(
                text: "Play vs CPU",
                icon: Icons.directions_boat,
                customOnTap: () {
                  Navigator.pushNamed(
                    context,
                    '/game',
                    arguments: GameMode.vsCpu,
                  );
                },
              ),
            ),

            Positioned(
              top: Positioning.getActualDeviceHeight(570),
              child: customButton(
                text: "Play vs Friend",
                icon: Icons.people,
                customOnTap: () {
                  Navigator.pushNamed(
                    context,
                    '/game',
                    arguments: GameMode.vsFriend,
                  );
                },
              ),
            ),

            Positioned(
              bottom: Positioning.safeAreaPaddingBottom,
              child: CustomNavigationBar(),
            ),
          ],
        ),
      ),
    );
  }

  Widget customButton({
    required String text,
    required IconData icon,
    required Function() customOnTap,
  }) {
    return InkWell(
      onTap: customOnTap,
      child: Container(
        height: Positioning.getActualDeviceHeight(59),
        width: Positioning.getActualDeviceWidth(342),
        decoration: BoxDecoration(border: Border.all(color: Color(0xff162839))),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(onPressed: () {}, icon: Icon(icon)),
            Text(
              text,
              style: TextStyle(
                fontSize: Positioning.getAssetSize(28),
                fontFamily: CustomThemeData.fontFamilyBricolage,
                color: Color(0xff162839),
                fontVariations: [FontVariation.weight(800)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TicTacLogo extends StatelessWidget {
  const TicTacLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ticTacToeText("TIC"),
        ticTacToeText("TAC"),
        ticTacToeText("TOE"),
      ],
    );
  }

  Widget ticTacToeText(String text) {
    return Container(
      alignment: Alignment.center,
      height: Positioning.getActualDeviceHeight(80),
      margin: EdgeInsets.only(bottom: Positioning.getActualDeviceHeight(10)),
      child: Text(
        text,
        style: TextStyle(
          height: 0.8,
          letterSpacing: -4.2,
          fontSize: Positioning.getAssetSize(84),
          fontFamily: CustomThemeData.fontFamilyBricolage,
          color: Color(0xff162839),
          fontVariations: [
            FontVariation.weight(800),
            FontVariation.opticalSize(84),
          ],
        ),
      ),
    );
  }
}
