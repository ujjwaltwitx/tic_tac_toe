import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../ad_mob_config.dart';
import '../domain/ports/interstitial_ad_port.dart';

class AdMobInterstitialService implements InterstitialAdPort {
  InterstitialAd? _ad;
  bool _isLoading = false;
  int? _shownForRound;

  static Future<void> initializeSdk() {
    return MobileAds.instance.initialize();
  }

  @override
  Future<void> preload() async {
    if (_ad != null || _isLoading) {
      return;
    }
    _isLoading = true;
    await InterstitialAd.load(
      adUnitId: AdMobConfig.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _ad = ad;
          _isLoading = false;
        },
        onAdFailedToLoad: (error) {
          _ad = null;
          _isLoading = false;
        },
      ),
    );
  }

  @override
  Future<bool> showAfterCompletedRound(int completedRound) async {
    if (completedRound <= 0 ||
        completedRound % AdMobConfig.interstitialEveryNRounds != 0 ||
        _shownForRound == completedRound) {
      return false;
    }
    final ad = _ad;
    if (ad == null) {
      await preload();
      return false;
    }
    _ad = null;
    _shownForRound = completedRound;
    final done = Completer<void>();
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (shown) {
        shown.dispose();
        if (!done.isCompleted) {
          done.complete();
        }
        preload();
      },
      onAdFailedToShowFullScreenContent: (shown, error) {
        shown.dispose();
        if (!done.isCompleted) {
          done.complete();
        }
        preload();
      },
    );
    await ad.show();
    await done.future;
    return true;
  }
}
