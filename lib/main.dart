import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'splashscreen.dart';

String appid = "5454374";
bool mode = false;
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
class AdManager {
  static String get gameId {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return appid;
    }
    return appid;
  }

  static String get bannerAdPlacementId {
    return 'Banner_iOS';
  }

  static String get interstitialVideoAdPlacementId {
    return 'Interstitial_iOS';
  }

  static String get rewardedVideoAdPlacementId {
    return 'Rewarded_iOS';
  }
}