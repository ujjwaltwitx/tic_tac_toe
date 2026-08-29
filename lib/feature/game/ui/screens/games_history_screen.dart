import 'package:flutter/material.dart';
import 'package:tic_tac_toe/shared/custom_theme_data.dart';
import 'package:tic_tac_toe/shared/utilities/positioning.dart';
import 'package:tic_tac_toe/shared/widgets/navbar_widget.dart';

import '../../../../shared/widgets/top_bar_widget.dart';

class GamesHistoryScreen extends StatelessWidget {
  GamesHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Positioning.screenWidth,
        height: Positioning.screenHeight,
        padding: EdgeInsets.only(
          top: Positioning.safeAreaPaddingTop,
          bottom: Positioning.safeAreaPaddingBottom,
        ),
        child: Column(
          children: [
            TopBarWidget(),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return InfoCardWidget(
                    tiltAngle: index % 2 == 0 ? 0.01 : -0.01,
                    isWin: index % 2 == 0,
                    isDraw: index % 3 == 0,
                  );
                },
              ),
            ),
            CustomNavigationBar(),
          ],
        ),
      ),
    );
  }

  SizedBox trailingTextWidget() {
    return SizedBox(
      height: 66,
      width: 300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(color: Color(0xff162839), height: 3, width: 100),
          Text(
            "Earlier",
            style: TextStyle(
              fontSize: 20,
              fontFamily: CustomThemeData.fontFamilyKarla,
              fontWeight: FontWeight.normal,
              color: Color(0xff162839),
            ),
          ),
          Container(color: Color(0xff162839), height: 3, width: 100),
        ],
      ),
    );
  }
}

class InfoCardWidget extends StatelessWidget {
  final bool isWin;
  final bool isDraw;
  final double tiltAngle;

  InfoCardWidget({
    super.key,
    required this.isWin,
    required this.isDraw,
    required this.tiltAngle,
  }) {
    setColors(isWin, isDraw);
  }

  Color titleColor = Color(0xffb02d21);
  Color subtitleUserColor = Color(0xffb02d21);
  Color subtitleOpponentColor = Color(0xff162839);
  String titleText = "Win";

  void setColors(bool isWin, bool isDraw) {
    if (!isWin && !isDraw) {
      titleColor = Color(0xff43474c).withOpacity(0.8);
      subtitleUserColor = Color(0xff162839);
      subtitleOpponentColor = Color(0xffb02d21);
      titleText = "Loss";
      return;
    }

    if (isDraw) {
      titleColor = Color(0xff2c3e50);
      subtitleUserColor = Color(0xff162839);
      subtitleOpponentColor = Color(0xff162839);
      titleText = "Draw";
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: tiltAngle,
      child: Center(
        child: Container(
          height: Positioning.getActualDeviceHeight(140),
          width: Positioning.getActualDeviceWidth(342),
          margin: EdgeInsets.only(bottom: Positioning.getAssetSize(20)),
          padding: EdgeInsets.all(Positioning.getAssetSize(10)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Positioning.getAssetSize(10)),
            border: Border.all(
              color: const Color(0xff162839).withOpacity(0.2),
              width: Positioning.getAssetSize(1),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    titleText,
                    style: TextStyle(
                      fontSize: Positioning.getAssetSize(20),
                      fontWeight: FontWeight.normal,
                      fontFamily: CustomThemeData.fontFamilyBricolage,
                      color: titleColor,
                    ),
                  ),
                  Text(
                    "29 Aug 2026",
                    style: TextStyle(
                      fontSize: Positioning.getAssetSize(14),
                      fontWeight: FontWeight.bold,
                      fontFamily: CustomThemeData.fontFamilyKarla,
                      color: Color(0xff43474c),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "X",
                        style: TextStyle(
                          fontSize: Positioning.getAssetSize(16),
                          fontWeight: FontWeight.normal,
                          fontFamily: CustomThemeData.fontFamilyBricolage,
                          color: Color(0xff162839),
                        ),
                      ),
                      Text(
                        "3",
                        style: TextStyle(
                          fontSize: Positioning.getAssetSize(16),
                          fontFamily: CustomThemeData.fontFamilyBricolage,
                          color: subtitleUserColor,
                          fontVariations: [
                            FontVariation.opticalSize(16),
                            FontVariation.weight(400),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "vs",
                    style: TextStyle(
                      fontSize: Positioning.getAssetSize(16),
                      fontWeight: FontWeight.normal,
                      fontFamily: CustomThemeData.fontFamilyKarla,
                      color: Color(0xff43474c),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        "O",
                        style: TextStyle(
                          fontSize: Positioning.getAssetSize(16),
                          fontWeight: FontWeight.normal,
                          fontFamily: CustomThemeData.fontFamilyBricolage,
                          color: Color(0xff162839),
                        ),
                      ),
                      Text(
                        "3",
                        style: TextStyle(
                          fontSize: Positioning.getAssetSize(16),
                          fontFamily: CustomThemeData.fontFamilyBricolage,
                          color: subtitleOpponentColor,
                          fontVariations: [
                            FontVariation.opticalSize(16),
                            FontVariation.weight(400),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
