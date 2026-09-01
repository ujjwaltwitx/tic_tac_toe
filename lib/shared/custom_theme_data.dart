import 'dart:ui';

class CustomThemeData {
  static const Color primaryColor = Color(0xFF2c3e50);
  static const Color secondaryColor = Color(0xFFc0392b);
  static const Color tertiaryColor = Color(0xFFf4f1ea);
  static const Color neutralColor = Color(0xFF5d6d7e);

  static const String fontFamilyBricolage = "Bricolage Grotesque";
  static const String fontFamilyKarla = "Karla";
  static const String fontFamilyPatrickHand = "Patrick Hand";

  static const Color markX = Color(0xffb02d21);
  static const Color markO = Color(0xff162839);

  static Color colorForMark(String mark) {
    if (mark == 'O') {
      return markO;
    }
    if (mark == 'X') {
      return markX;
    }
    return const Color(0xff162839);
  }
}
