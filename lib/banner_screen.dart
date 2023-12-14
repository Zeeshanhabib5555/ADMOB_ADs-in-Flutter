import 'package:admob_ads_flutter/data_admob/admob_manager.dart';
import 'package:admob_ads_flutter/interstitial_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerScreen extends StatefulWidget {
  const BannerScreen({super.key});

  @override
  State<BannerScreen> createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> {

  late BannerAd _bannerAd;
  bool isBannerAdLoaded = false;
  double height_banner = 50;

  //Create Function
  initBannerAd (){
    _bannerAd = BannerAd(
        adUnitId: AdmobManager.banner_id,
        request: const AdRequest(),
        size: AdSize.banner,
        listener: BannerAdListener(
          //This is used for when Ads is loaded
          onAdLoaded: (Ad ad){

            setState(() {
              isBannerAdLoaded = true;
            });

          },
            //This is used for when Ads is failed to load
          onAdFailedToLoad: (Ad ad, LoadAdError error){
            ad.dispose();

    },
          //This is used for when Ads is opened
          onAdOpened: (Ad ad){

          },
        ),
        );
    _bannerAd.load();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initBannerAd();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _bannerAd.dispose(); //when screen is destroy than also ads is destroy
  }

  Widget GetBanner(){
    return isBannerAdLoaded ? Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      color: Colors.amberAccent,
      width: _bannerAd.size.width.toDouble(),
      height: _bannerAd.size.height.toDouble(),
       child:AdWidget(ad: _bannerAd),
      

    )
        : SizedBox(height: height_banner,);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Center(child: Text('Banner')),
      ),
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        child: InkWell
          (
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>InterstitialScreen()));
            },
            child: Text("Open Interstitial Screen")),
      ),
      bottomNavigationBar: GetBanner(),
    );

  }
}
