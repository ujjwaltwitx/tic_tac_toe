import 'package:flutter/material.dart';

import '../custom_theme_data.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});
  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int _selectedIndex = 0;

  Color _getColor(int index) {
    if (index == _selectedIndex) {
      return Color(0xffb02d21);
    }
    return Color(0xff43474c);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 72,
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xff162839), width: 4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              setState(() {
                _selectedIndex = 0;
              });
            },
            child: Container(
              height: 50,
              width: 70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.gamepad, color: _getColor(0)),
                  Text(
                    "Play",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: CustomThemeData.fontFamilyKarla,
                      color: _getColor(0),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              setState(() {
                _selectedIndex = 1;
              });
            },
            child: Container(
              height: 50,
              width: 70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history, color: _getColor(1)),
                  Text(
                    "History",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: CustomThemeData.fontFamilyKarla,
                      color: _getColor(1),
                    ),
                  ),
                ],
              ),
            ),
          ),

          InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              setState(() {
                _selectedIndex = 2;
              });
            },
            child: Container(
              height: 50,
              width: 70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.settings, color: _getColor(2)),
                  Text(
                    "Settings",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: CustomThemeData.fontFamilyKarla,
                      color: _getColor(2),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
