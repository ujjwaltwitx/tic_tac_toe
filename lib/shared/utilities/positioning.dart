import 'dart:math';

import 'package:flutter/widgets.dart';

class Positioning {
  static double screenWidth = 0;
  static double screenHeight = 0;
  static double blockSize = 0;
  static double safeAreaPadding = 0;
  static double safeAreaPaddingTop = 0;
  static double safeAreaPaddingBottom = 0;
  static double safeAreaPaddingLeft = 0;
  static double safeAreaPaddingRight = 0;
  static double safeAreaPaddingHorizontal = 0;
  static double safeAreaPaddingVertical = 0;
  static const int DESIGN_WIDTH = 390;
  static const int DESIGN_HEIGHT = 884;
  static void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    blockSize = screenWidth / 100;
    safeAreaPadding = MediaQuery.of(context).padding.top;
    safeAreaPaddingTop = MediaQuery.of(context).padding.top;
    safeAreaPaddingBottom = MediaQuery.of(context).padding.bottom;
    safeAreaPaddingLeft = MediaQuery.of(context).padding.left;
    safeAreaPaddingRight = MediaQuery.of(context).padding.right;
    safeAreaPaddingHorizontal = MediaQuery.of(context).padding.horizontal;
    safeAreaPaddingVertical = MediaQuery.of(context).padding.vertical;
  }

  static double getActualDeviceWidth(double width) {
    return width * (screenWidth / DESIGN_WIDTH);
  }

  static double getActualDeviceHeight(double height) {
    return height * (screenHeight / DESIGN_HEIGHT);
  }

  static double getAssetSize(double size) {
    return min(getActualDeviceHeight(size), getActualDeviceWidth(size));
  }
}
