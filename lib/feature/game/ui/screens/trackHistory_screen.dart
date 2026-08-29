import 'package:flutter/material.dart';
import 'package:tic_tac_toe/shared/custom_theme_data.dart';
import 'package:tic_tac_toe/shared/widgets/navbar_widget.dart';

class TrackHistory extends StatelessWidget {
  const TrackHistory({super.key});

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
            Positioned(top: 80, child: winRecord()),
            Positioned(top: 250, child: lossRecord()),
            Positioned(top: 420, child: drawRecord()),
            Positioned(
              top: 600,
              child: SizedBox(
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
              ),
            ),

            Positioned(bottom: 50, child: CustomNavigationBar()),
          ],
        ),
      ),
    );
  }

  Container winRecord() {
    return Container(
      height: 150,
      width: 350,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(color: const Color(0xff162839)),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Win",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  fontFamily: CustomThemeData.fontFamilyBricolage,
                  color: Color(0xffb02d21),
                ),
              ),
              Text(
                "X",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: CustomThemeData.fontFamilyBricolage,
                  color: Color(0xff162839),
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                "3",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: CustomThemeData.fontFamilyBricolage,
                  color: Color(0xffb02d21),
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "vs",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  fontFamily: CustomThemeData.fontFamilyBricolage,
                  color: Color(0xff43474c),
                ),
              ),
            ],
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "29 Aug 2026",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  fontFamily: CustomThemeData.fontFamilyBricolage,
                  color: Color(0xff162839),
                ),
              ),
              Text(
                "O",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: CustomThemeData.fontFamilyBricolage,
                  color: const Color(0xff162839),
                ),
              ),

              Text(
                "3",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: CustomThemeData.fontFamilyBricolage,
                  color: const Color(0xff162839),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container lossRecord() {
    return Container(
      height: 150,
      width: 350,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(color: const Color(0xff162839)),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Loss",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  fontFamily: CustomThemeData.fontFamilyBricolage,
                  color: Color(0xff43474c),
                ),
              ),
              Text(
                "X",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: CustomThemeData.fontFamilyBricolage,
                  color: Color(0xff162839),
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                "3",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: CustomThemeData.fontFamilyBricolage,
                  color: Color(0xff162839),
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "vs",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  fontFamily: CustomThemeData.fontFamilyBricolage,
                  color: Color(0xff43474c),
                ),
              ),
            ],
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "29 Aug 2026",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  fontFamily: CustomThemeData.fontFamilyBricolage,
                  color: Color(0xff162839),
                ),
              ),
              Text(
                "O",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: CustomThemeData.fontFamilyBricolage,
                  color: const Color(0xff162839),
                ),
              ),

              Text(
                "3",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: CustomThemeData.fontFamilyBricolage,
                  color: const Color(0xffb02d21),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container drawRecord() {
    return Container(
      height: 150,
      width: 350,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(color: const Color(0xff162839)),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Draw",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  fontFamily: CustomThemeData.fontFamilyBricolage,
                  color: Color(0xff2c3e50),
                ),
              ),
              Text(
                "X",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: CustomThemeData.fontFamilyBricolage,
                  color: Color(0xff162839),
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                "3",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: CustomThemeData.fontFamilyBricolage,
                  color: Color(0xff162839),
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "vs",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  fontFamily: CustomThemeData.fontFamilyBricolage,
                  color: Color(0xff43474c),
                ),
              ),
            ],
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "29 Aug 2026",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  fontFamily: CustomThemeData.fontFamilyBricolage,
                  color: Color(0xff162839),
                ),
              ),
              Text(
                "O",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: CustomThemeData.fontFamilyBricolage,
                  color: const Color(0xff162839),
                ),
              ),

              Text(
                "3",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: CustomThemeData.fontFamilyBricolage,
                  color: const Color(0xff162839),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
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
          "Match History",
          style: TextStyle(
            fontSize: 28,
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
