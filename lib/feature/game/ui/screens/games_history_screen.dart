import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/feature/game/domain/date_key.dart';
import 'package:tic_tac_toe/feature/game/domain/day_history.dart';
import 'package:tic_tac_toe/feature/game/presentation/cubit/history_cubit.dart';
import 'package:tic_tac_toe/shared/custom_theme_data.dart';
import 'package:tic_tac_toe/shared/utilities/positioning.dart';
import 'package:tic_tac_toe/shared/widgets/navbar_widget.dart';

import '../../../../shared/widgets/top_bar_widget.dart';

class GamesHistoryScreen extends StatelessWidget {
  const GamesHistoryScreen({super.key});

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
            const TopBarWidget(),
            Expanded(
              child: BlocBuilder<HistoryCubit, List<DayHistory>>(
                builder: (context, days) {
                  if (days.isEmpty) {
                    return Center(
                      child: Text(
                        'No games yet',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: CustomThemeData.fontFamilyKarla,
                          color: const Color(0xff43474c),
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: days.length,
                    itemBuilder: (context, index) {
                      return InfoCardWidget(
                        day: days[index],
                        tiltAngle: index % 2 == 0 ? 0.01 : -0.01,
                      );
                    },
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
}

class InfoCardWidget extends StatelessWidget {
  const InfoCardWidget({super.key, required this.day, required this.tiltAngle});

  final DayHistory day;
  final double tiltAngle;

  @override
  Widget build(BuildContext context) {
    final titleColor =
        day.xWins == day.oWins
            ? const Color(0xff2c3e50)
            : day.xWins > day.oWins
            ? const Color(0xffb02d21)
            : const Color(0xff43474c).withValues(alpha: 0.8);
    final subtitleUserColor =
        day.xWins >= day.oWins
            ? const Color(0xffb02d21)
            : const Color(0xff162839);
    final subtitleOpponentColor =
        day.oWins > day.xWins
            ? const Color(0xffb02d21)
            : const Color(0xff162839);

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
              color: const Color(0xff162839).withValues(alpha: 0.2),
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
                    day.title,
                    style: TextStyle(
                      fontSize: Positioning.getAssetSize(20),
                      fontWeight: FontWeight.normal,
                      fontFamily: CustomThemeData.fontFamilyBricolage,
                      color: titleColor,
                    ),
                  ),
                  Text(
                    DateKey.display(day.date),
                    style: TextStyle(
                      fontSize: Positioning.getAssetSize(14),
                      fontWeight: FontWeight.bold,
                      fontFamily: CustomThemeData.fontFamilyKarla,
                      color: const Color(0xff43474c),
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
                        'X',
                        style: TextStyle(
                          fontSize: Positioning.getAssetSize(16),
                          fontWeight: FontWeight.normal,
                          fontFamily: CustomThemeData.fontFamilyBricolage,
                          color: const Color(0xff162839),
                        ),
                      ),
                      Text(
                        '${day.xWins}',
                        style: TextStyle(
                          fontSize: Positioning.getAssetSize(16),
                          fontFamily: CustomThemeData.fontFamilyBricolage,
                          color: subtitleUserColor,
                          fontVariations: const [
                            FontVariation.opticalSize(16),
                            FontVariation.weight(400),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'vs',
                    style: TextStyle(
                      fontSize: Positioning.getAssetSize(16),
                      fontWeight: FontWeight.normal,
                      fontFamily: CustomThemeData.fontFamilyKarla,
                      color: const Color(0xff43474c),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        'O',
                        style: TextStyle(
                          fontSize: Positioning.getAssetSize(16),
                          fontWeight: FontWeight.normal,
                          fontFamily: CustomThemeData.fontFamilyBricolage,
                          color: const Color(0xff162839),
                        ),
                      ),
                      Text(
                        '${day.oWins}',
                        style: TextStyle(
                          fontSize: Positioning.getAssetSize(16),
                          fontFamily: CustomThemeData.fontFamilyBricolage,
                          color: subtitleOpponentColor,
                          fontVariations: const [
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
