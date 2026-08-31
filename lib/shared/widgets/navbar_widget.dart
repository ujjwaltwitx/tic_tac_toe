import 'package:flutter/material.dart';

import '../custom_theme_data.dart';
import '../utilities/positioning.dart';

class CustomNavigationBar extends StatefulWidget {
  static int selectedIndex = 0;
  CustomNavigationBar({super.key});
  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Positioning.screenWidth,
      height: Positioning.getActualDeviceHeight(72),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xff162839), width: 4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomIconButton(
            index: 0,
            icon: Icons.home,
            text: "Home",
            customOnTap: () {
              if (CustomNavigationBar.selectedIndex == 0) return;
              Navigator.pushReplacementNamed(context, "/");
              setState(() {
                CustomNavigationBar.selectedIndex = 0;
              });
            },
          ),
          CustomIconButton(
            index: 1,
            icon: Icons.history,
            text: "History",
            customOnTap: () {
              if (CustomNavigationBar.selectedIndex == 1) return;
              Navigator.pushReplacementNamed(context, "/history");
              setState(() {
                CustomNavigationBar.selectedIndex = 1;
              });
            },
          ),
          CustomIconButton(
            index: 2,
            icon: Icons.settings,
            text: "Settings",
            customOnTap: () {
              if (CustomNavigationBar.selectedIndex == 2) return;
              Navigator.pushReplacementNamed(context, "/settings");
              setState(() {
                CustomNavigationBar.selectedIndex = 2;
              });
            },
          ),
        ],
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.index,
    required this.icon,
    required this.text,
    required this.customOnTap,
  });

  final int index;
  final IconData icon;
  final Function() customOnTap;
  final String text;

  Color _getColor(int index) {
    if (index == CustomNavigationBar.selectedIndex) {
      return Color(0xffb02d21);
    }
    return Color(0xff43474c);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: customOnTap,
      child: SizedBox(
        height: 50,
        width: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: _getColor(index)),
            Text(
              text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: CustomThemeData.fontFamilyKarla,
                color: _getColor(index),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
