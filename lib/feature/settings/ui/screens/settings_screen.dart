import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/feature/settings/domain/app_settings.dart';
import 'package:tic_tac_toe/feature/settings/presentation/cubit/settings_cubit.dart';
import 'package:tic_tac_toe/shared/custom_theme_data.dart';
import 'package:tic_tac_toe/shared/utilities/positioning.dart';
import 'package:tic_tac_toe/shared/widgets/navbar_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const _ink = Color(0xff162839);
  static const _accent = Color(0xffb02d21);
  static const _checkBlue = Color(0xff1a73e8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f1ea),
      body: Container(
        width: Positioning.screenWidth,
        height: Positioning.screenHeight,
        padding: EdgeInsets.only(
          top: Positioning.safeAreaPaddingTop,
          bottom: Positioning.safeAreaPaddingBottom,
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: BlocBuilder<SettingsCubit, AppSettings>(
                  builder: (context, settings) {
                    return Container(
                      width: Positioning.getActualDeviceWidth(342),
                      padding: EdgeInsets.symmetric(
                        horizontal: Positioning.getActualDeviceWidth(28),
                        vertical: Positioning.getActualDeviceHeight(28),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: _ink, width: 2),
                        borderRadius: BorderRadius.circular(
                          Positioning.getAssetSize(36),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Settings',
                            style: TextStyle(
                              fontSize: Positioning.getAssetSize(28),
                              fontFamily: CustomThemeData.fontFamilyBricolage,
                              color: _ink,
                              fontVariations: const [
                                FontVariation.weight(800),
                              ],
                            ),
                          ),
                          SizedBox(height: Positioning.getActualDeviceHeight(6)),
                          Container(
                            width: Positioning.getActualDeviceWidth(72),
                            height: Positioning.getAssetSize(5),
                            decoration: BoxDecoration(
                              color: _accent,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          SizedBox(
                            height: Positioning.getActualDeviceHeight(36),
                          ),
                          _settingRow(
                            label: 'Sound Effects',
                            value: settings.soundEnabled,
                            onChanged: (value) {
                              context
                                  .read<SettingsCubit>()
                                  .setSoundEnabled(value);
                            },
                          ),
                          SizedBox(
                            height: Positioning.getActualDeviceHeight(20),
                          ),
                          _settingRow(
                            label: 'Haptic Feedback',
                            value: settings.hapticsEnabled,
                            onChanged: (value) {
                              context
                                  .read<SettingsCubit>()
                                  .setHapticsEnabled(value);
                            },
                          ),
                          SizedBox(
                            height: Positioning.getActualDeviceHeight(40),
                          ),
                          InkWell(
                            onTap: () {
                              CustomNavigationBar.selectedIndex = 0;
                              Navigator.pushReplacementNamed(context, '/');
                            },
                            child: Container(
                              width: double.infinity,
                              height: Positioning.getActualDeviceHeight(52),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(color: _ink, width: 2),
                                borderRadius: BorderRadius.circular(
                                  Positioning.getAssetSize(8),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Back to Game',
                                    style: TextStyle(
                                      fontSize: Positioning.getAssetSize(16),
                                      fontFamily:
                                          CustomThemeData.fontFamilyKarla,
                                      fontWeight: FontWeight.w700,
                                      color: _accent,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Positioning.getAssetSize(8),
                                  ),
                                  Icon(
                                    Icons.undo,
                                    color: _accent,
                                    size: Positioning.getAssetSize(18),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            CustomNavigationBar(),
          ],
        ),
      ),
    );
  }

  Widget _settingRow({
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: Positioning.getAssetSize(18),
            fontFamily: CustomThemeData.fontFamilyKarla,
            fontWeight: FontWeight.w600,
            color: _ink,
          ),
        ),
        SizedBox(
          width: Positioning.getAssetSize(28),
          height: Positioning.getAssetSize(28),
          child: Checkbox(
            value: value,
            onChanged: (next) {
              if (next != null) {
                onChanged(next);
              }
            },
            activeColor: _checkBlue,
            side: const BorderSide(color: Color(0xffc4c6cd), width: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ),
      ],
    );
  }
}
