import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../shared/custom_theme_data.dart';
import '../../../../shared/utilities/game_constants.dart';
import '../../../../shared/utilities/game_util.dart';
import '../../../../shared/utilities/positioning.dart';

class GameOverScreen extends StatelessWidget {
  const GameOverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: Positioning.safeAreaPaddingTop),
        width: Positioning.screenWidth,
        height: Positioning.screenHeight,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              GameUtil.getAssetPath(GameConstants.backgroundImage),
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(),
            Positioned(
              top: Positioning.getActualDeviceHeight(149),
              child: Container(
                height: Positioning.getActualDeviceHeight(501),
                width: Positioning.getActualDeviceWidth(350),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xff162839), width: 3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: Positioning.getActualDeviceHeight(35),
                      child: Text(
                        'X',
                        style: TextStyle(
                          fontSize: 84,
                          fontFamily: CustomThemeData.fontFamilyKarla,
                          fontVariations: [
                            FontVariation('opsz', 84),
                            FontVariation('wght', 800),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: Positioning.getActualDeviceHeight(127),
                      child: Transform.rotate(
                        angle: pi / 180 * 2,
                        child: Text(
                          "WINS!",
                          style: TextStyle(
                            fontSize: 28,
                            fontFamily: CustomThemeData.fontFamilyBricolage,
                            fontVariations: [
                              // FontVariation('opsz', 28),
                              FontVariation.weight(700),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: Positioning.getActualDeviceHeight(195),
                      child: Transform.rotate(
                        angle: pi / 180 * -2,
                        child: Container(
                          width: Positioning.getActualDeviceWidth(110),
                          height: Positioning.getActualDeviceHeight(48),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xffc4c6cd),
                              width: Positioning.getAssetSize(2),
                            ),
                            borderRadius: BorderRadius.circular(
                              Positioning.getAssetSize(6),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.emoji_events_outlined,
                                color: Color(0xff43474c),
                              ),
                              Text(
                                "Streak : 3",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: CustomThemeData.fontFamilyKarla,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff43474c),
                                ),
                              ),
                              SizedBox(width: Positioning.getAssetSize(8)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Button one
                    Positioned(
                      top: Positioning.getActualDeviceHeight(277),
                      child: Container(
                        width: Positioning.getActualDeviceWidth(280),
                        height: Positioning.getActualDeviceHeight(70),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xffb02d21),
                            width: Positioning.getAssetSize(2),
                          ),
                          borderRadius: BorderRadius.circular(
                            Positioning.getAssetSize(3),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Play Again",
                              style: TextStyle(
                                fontSize: 22,
                                fontFamily: CustomThemeData.fontFamilyBricolage,
                                color: Color(0xffb02d21),
                                fontVariations: [
                                  FontVariation.weight(700),
                                  FontVariation.opticalSize(22),
                                ],
                              ),
                            ),
                            Icon(Icons.refresh, color: Color(0xffb02d21)),
                          ],
                        ),
                      ),
                    ),

                    Positioned(
                      top: Positioning.getActualDeviceHeight(273),
                      left: Positioning.getActualDeviceWidth(30),
                      child: Transform.rotate(
                        origin: Offset(
                          0,
                          Positioning.getActualDeviceHeight(70),
                        ),
                        angle: pi / 180 * -2,
                        child: Container(
                          width: Positioning.getActualDeviceWidth(280),
                          height: Positioning.getActualDeviceHeight(70),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xffb02d21),
                              width: Positioning.getAssetSize(2),
                            ),
                            borderRadius: BorderRadius.circular(
                              Positioning.getAssetSize(3),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Button two
                    Positioned(
                      top: Positioning.getActualDeviceHeight(366),
                      left: Positioning.getActualDeviceWidth(30),
                      child: Transform.rotate(
                        origin: Offset(
                          0,
                          Positioning.getActualDeviceHeight(70),
                        ),
                        angle: pi / 180 * -2,
                        child: Container(
                          width: Positioning.getActualDeviceWidth(280),
                          height: Positioning.getActualDeviceHeight(46),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: Color(0xff162839),
                              width: Positioning.getAssetSize(2),
                            ),
                            borderRadius: BorderRadius.circular(
                              Positioning.getAssetSize(4),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: Positioning.getActualDeviceHeight(370),
                      child: InkWell(
                        onTap: () {
                          print("Main Menu");
                          // TODO: Implement main menu navigation
                        },
                        child: Container(
                          width: Positioning.getActualDeviceWidth(280),
                          height: Positioning.getActualDeviceHeight(46),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xff162839),
                              width: Positioning.getAssetSize(2),
                            ),
                            borderRadius: BorderRadius.circular(
                              Positioning.getAssetSize(4),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Main Menu",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: CustomThemeData.fontFamilyKarla,
                                  color: Color(0xff162839),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: Color(0xff162839),
                                size: 14,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: Positioning.getActualDeviceHeight(33),
                      child: Text(
                        "Better luck next time, O.",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: CustomThemeData.fontFamilyKarla,
                          color: Color(0xff43474c).withValues(alpha: 0.7),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
