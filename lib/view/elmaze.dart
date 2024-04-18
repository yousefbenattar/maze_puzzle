import 'package:flutter/material.dart';
import 'package:maze/maze.dart';
import 'package:maze_puzzle/view/home.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';
import '../main.dart';
import '../model/data.dart';

class ElMaze extends StatefulWidget {
  const ElMaze({
    super.key,
    required this.data,
  });
  final Data data;

  @override
  State<ElMaze> createState() => _ElMazeState();
}

class _ElMazeState extends State<ElMaze> {
  Map<String, bool> placements = {
    AdManager.interstitialVideoAdPlacementId: false,
    AdManager.rewardedVideoAdPlacementId: false,
  };
  void _loadAds() {
    for (var placementId in placements.keys) {
      _loadAd(placementId);
    }
  }

  void _loadAd(String placementId) {
    UnityAds.load(
      placementId: placementId,
      onComplete: (placementId) {
        setState(() {
          placements[placementId] = true;
        });
      },
      onFailed: (placementId, error, message) => null,
    );
  }

  void _showAd(String placementId) {
    setState(() {
      placements[placementId] = false;
    });
    UnityAds.showVideoAd(
      placementId: placementId,
      onComplete: (placementId) {
        _loadAd(placementId);
      },
      onFailed: (placementId, error, message) {
        _loadAd(placementId);
      },
      onStart: (placementId) => null,
      onClick: (placementId) => null,
      onSkipped: (placementId) {
        _loadAd(placementId);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    UnityAds.init(
      gameId: AdManager.gameId,
      testMode: mode,
      onComplete: () {
        _loadAds();
      },
      onFailed: (error, message) => null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              _showAd(AdManager.interstitialVideoAdPlacementId);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const Home()),
                  (route) => false);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: SafeArea(
          child: Maze(
              player: MazeItem(widget.data.img_1, ImageType.asset),
              columns: 6,
              rows: 12,
              wallThickness: 4.0,
              wallColor: Theme.of(context).primaryColor,
              finish: MazeItem(widget.data.img_2, ImageType.asset),
              onFinish: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text('Congrats you finished the maze'),
                          actions: [
                            IconButton(
                                onPressed: () {
                                  _showAd(
                                      AdManager.interstitialVideoAdPlacementId);
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ElMaze(data: widget.data)),
                                      (route) => false);
                                },
                                icon: const Icon(Icons.done))
                          ],
                        ));
              })),
      bottomNavigationBar: UnityBannerAd(
        placementId: AdManager.bannerAdPlacementId,
      ),
    );
  }
}
