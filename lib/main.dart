import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic_tac_toe/feature/ads/data/admob_interstitial_service.dart';
import 'package:tic_tac_toe/feature/ads/domain/ports/interstitial_ad_port.dart';
import 'package:tic_tac_toe/feature/game/data/daily_challenge_scheduler.dart';
import 'package:tic_tac_toe/feature/game/data/shared_preferences_game_progress_repository.dart';
import 'package:tic_tac_toe/feature/game/domain/cpu_player.dart';
import 'package:tic_tac_toe/feature/game/domain/game_board_engine.dart';
import 'package:tic_tac_toe/feature/game/domain/game_mode.dart';
import 'package:tic_tac_toe/feature/game/domain/ports/game_progress_port.dart';
import 'package:tic_tac_toe/feature/game/presentation/cubit/game_cubit.dart';
import 'package:tic_tac_toe/feature/game/presentation/cubit/history_cubit.dart';
import 'package:tic_tac_toe/feature/game/presentation/cubit/landing_cubit.dart';
import 'package:tic_tac_toe/feature/game/ui/screens/landing_screen.dart';
import 'package:tic_tac_toe/feature/game/ui/screens/games_history_screen.dart';
import 'package:tic_tac_toe/feature/settings/data/move_feedback.dart';
import 'package:tic_tac_toe/feature/settings/data/shared_preferences_app_settings_repository.dart';
import 'package:tic_tac_toe/feature/settings/domain/ports/app_settings_port.dart';
import 'package:tic_tac_toe/feature/settings/presentation/cubit/settings_cubit.dart';
import 'package:tic_tac_toe/feature/settings/ui/screens/settings_screen.dart';

import 'feature/game/ui/screens/game_over_screen.dart';
import 'feature/game/ui/screens/game_screen.dart';
import 'shared/navigation/app_page_transitions.dart';
import 'shared/utilities/positioning.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AdMobInterstitialService.initializeSdk();
  final interstitialAds = AdMobInterstitialService();
  await interstitialAds.preload();
  final prefs = await SharedPreferences.getInstance();
  final progress = SharedPreferencesGameProgressRepository(prefs);
  await progress.load();
  final appSettings = SharedPreferencesAppSettingsRepository(prefs);
  final moveFeedback = MoveFeedback(settings: appSettings);
  final scheduler = DailyChallengeScheduler(prefs: prefs, progress: progress);
  await scheduler.init();
  await scheduler.reschedule();
  runApp(
    MyApp(
      progress: progress,
      scheduler: scheduler,
      appSettings: appSettings,
      moveFeedback: moveFeedback,
      interstitialAds: interstitialAds,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.progress,
    required this.scheduler,
    required this.appSettings,
    required this.moveFeedback,
    required this.interstitialAds,
  });

  final GameProgressPort progress;
  final DailyChallengeScheduler scheduler;
  final AppSettingsPort appSettings;
  final MoveFeedback moveFeedback;
  final InterstitialAdPort interstitialAds;

  @override
  Widget build(BuildContext context) {
    Positioning.init(context);
    return BlocProvider(
      create: (_) => SettingsCubit(appSettings),
      child: MaterialApp(
        title: 'Tic Tac Toe',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: (settings) {
          if (settings.name == '/') {
            return AppPageTransitions.route<void>(
              builder: (_) => BlocProvider(
                create: (_) => LandingCubit(progress),
                child: const LandingScreen(),
              ),
              settings: settings,
            );
          }
          if (settings.name == '/history') {
            return AppPageTransitions.route<void>(
              builder: (_) => BlocProvider(
                create: (_) => HistoryCubit(progress),
                child: const GamesHistoryScreen(),
              ),
              settings: settings,
            );
          }
          if (settings.name == '/settings') {
            return AppPageTransitions.route<void>(
              builder: (_) => const SettingsScreen(),
              settings: settings,
            );
          }
          if (settings.name == '/game') {
            final mode = settings.arguments is GameMode
                ? settings.arguments as GameMode
                : GameMode.vsFriend;
            return AppPageTransitions.route<void>(
              builder: (_) => BlocProvider(
                create: (_) => GameCubit(
                  engine: GameBoardEngine(mode: mode),
                  cpuPlayer: CpuPlayer(),
                  progress: progress,
                  scheduler: scheduler,
                  moveFeedback: moveFeedback,
                  interstitialAds: interstitialAds,
                ),
                child: const GameScreen(),
              ),
              settings: settings,
            );
          }
          return null;
        },
        theme: ThemeData(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<List<String?>> board = List.generate(3, (_) => List.filled(3, null));
  bool shouldShowCross = true;
  bool gameOver = false;
  String msg = "X Turn";
  int count = 0;
  String buttonMsg = "RESET";
  void handleTap(int row, int col) {
    if (gameOver) {
      return;
    }
    if (board[row][col] != null) {
      return;
    }
    setState(() {
      board[row][col] = shouldShowCross ? "X" : "O";
      count++;
    });
    if (checkWinner()) {
      print("${shouldShowCross ? "X" : "O"} wins!");
      setState(() {
        gameOver = true;
        msg = "${shouldShowCross ? "X" : "O"} Wins!";
        buttonMsg = "PLAY AGAIN!";
        resetGame();
      });
      return;
    }
    if (count == 9) {
      resetGame();
    }

    setState(() {
      shouldShowCross = !shouldShowCross;
      msg = shouldShowCross ? "X Turn" : "O Turn";
      buttonMsg = "RESET";
    });
  }

  void resetGame() {
    setState(() {
      board = List.generate(3, (_) => List.filled(3, null));
    });
    shouldShowCross = true;
    gameOver = false;
    // msg = "X Turn";
    //buttonMsg = "RESET";
    count = 0;
  }

  bool checkWinner() {
    for (int row = 0; row < 3; row++) {
      if (board[row][0] != null &&
          board[row][0] == board[row][1] &&
          board[row][1] == board[row][2]) {
        return true;
      }
    }
    for (int col = 0; col < 3; col++) {
      if (board[0][col] != null &&
          board[0][col] == board[1][col] &&
          board[1][col] == board[2][col]) {
        return true;
      }
    }
    for (int row = 0; row < 3; row++) {
      if (board[0][0] != null &&
          board[0][0] == board[1][1] &&
          board[1][1] == board[2][2]) {
        return true;
      }
    }

    for (int row = 0; row < 3; row++) {
      if (board[0][2] != null &&
          board[0][2] == board[1][1] &&
          board[1][1] == board[2][0]) {
        return true;
      }
    }
    return false;
    // we  are left with diagonal check
  }

  @override
  Widget build(BuildContext context) {
    return GameOverScreen();
  }
}
