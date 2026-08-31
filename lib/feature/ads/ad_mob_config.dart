import 'package:flutter/foundation.dart';

class AdMobConfig {
  AdMobConfig._();

  static const int interstitialEveryNRounds = 3;

  static const String appId = 'ca-app-pub-2131138335044748~9810930428';

  static const String _productionInterstitialAdUnitId =
      'ca-app-pub-2131138335044748/2618836114';

  /// Google test interstitial. Used in debug so AdMob does not flag the account.
  static const String _testInterstitialAdUnitId =
      'ca-app-pub-3940256099942544/1033173712';

  static String get interstitialAdUnitId {
    if (kDebugMode) {
      return _testInterstitialAdUnitId;
    }
    return _productionInterstitialAdUnitId;
  }

  static const String _productionBannerAdUnitId =
      'ca-app-pub-2131138335044748/8657630851';

  static const String _testBannerAdUnitId =
      'ca-app-pub-3940256099942544/6300978111';

  static String get bannerAdUnitId {
    if (kDebugMode) {
      return _testBannerAdUnitId;
    }
    return _productionBannerAdUnitId;
  }
}
