import 'package:flutter/material.dart';

import '../custom_theme_data.dart';
import '../utilities/positioning.dart';

class TopBarWidget extends StatelessWidget {
  final bool showBackButton;

  const TopBarWidget({super.key, this.showBackButton = false});

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
        mainAxisAlignment:
            showBackButton
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.center,
        children: [
          if (showBackButton)
            Container(
              color: Colors.transparent,
              width: Positioning.getActualDeviceWidth(40),
              alignment: Alignment.center,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back),
              ),
            ),
          Text(
            "Tic Tac Toe",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              fontFamily: CustomThemeData.fontFamilyBricolage,
              color: Color(0xff162839),
            ),
          ),
          if (showBackButton)
            SizedBox(width: Positioning.getActualDeviceWidth(40)),
        ],
      ),
    );
  }
}
