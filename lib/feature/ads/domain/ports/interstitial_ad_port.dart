abstract interface class InterstitialAdPort {
  Future<void> preload();

  /// Shows an interstitial after every 3 completed rounds.
  /// Returns true if a full-screen ad was presented.
  Future<bool> showAfterCompletedRound(int completedRound);
}
