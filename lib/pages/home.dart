import 'dart:convert';

import 'package:coindcxclone/utils/storage/local_coin_storage.dart';
import 'package:coindcxclone/utils/models/coin.dart';
import 'package:coindcxclone/utils/models/coin_data.dart';
import 'package:coindcxclone/widgets/advert_card.dart';
import 'package:coindcxclone/widgets/navigation_bar.dart';
import 'package:coindcxclone/widgets/newly_launched.dart';
import 'package:coindcxclone/widgets/top_gainers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    loadData();
    // LocalCoinStorage().dumpFromNet();
  }

  loadData() async {
    if (CoinData.coins.isNotEmpty) return;
    var _data = await rootBundle.loadString("assets/data/coins.json");
    var _ddata = jsonDecode(_data);
    var _coins = _ddata["coins"];
    CoinData.coins = List.generate(10, (index) => Coin.fromMap(_coins[0]));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: (CoinData.coins.isNotEmpty)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(
                        child: Text(
                          "Hi Samarth 👋",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      AdvertCard(),
                      NewlyLaunched(),
                      TopGainers(),
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ),
      ),
      bottomNavigationBar: const DefaultNavigationBar(
        currentIndex: 0,
      ),
    );
  }
}
