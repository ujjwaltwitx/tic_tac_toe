import 'package:flutter/material.dart';

import '../custom_theme_data.dart';
import '../utilities/positioning.dart';

class TopBarWidget extends StatelessWidget {
  const TopBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Positioning.getActualDeviceWidth(390),
      height: Positioning.getActualDeviceHeight(48),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xff162839),
            width: Positioning.getActualDeviceWidth(2),
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
          Text(
            "Tic Tac Toe",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              fontFamily: CustomThemeData.fontFamilyBricolage,
              color: Color(0xff162839),
            ),
          ),
          // IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
        ],
      ),
    );
  }
}
