import 'package:flutter/material.dart';
import 'package:maze_puzzle/model/data.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';
import '../main.dart';
import 'bar.dart';
import 'elmaze.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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


    String userName = 'User Name';

  void updateUserName(String newName) {
    setState(() {
      userName = newName;
    });
    debugPrint('User name updated: $newName');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text(""),),
        drawer: SideBar(
        userName: userName,
        onNameUpdated: updateUserName,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GridView.builder(
          itemCount: dataList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10),
            itemBuilder: (context, i) {
              Data data = dataList[i];
              return InkWell(
                onTap: (){
                 _showAd(AdManager.interstitialVideoAdPlacementId);
                  Navigator.push(context, MaterialPageRoute(builder: (builder)=> ElMaze( data: data,)));
                },
                child: Card(
                  child: Image(image: AssetImage(dataList[i].img_1)),
                ),
              );
            }),
      ),
      bottomNavigationBar: UnityBannerAd(placementId: AdManager.bannerAdPlacementId,),

    );
  }
  
}
