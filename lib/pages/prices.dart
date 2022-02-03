import 'package:coindcxclone/pages/tabs/watchlist.dart';
import 'package:coindcxclone/widgets/display_coin.dart';
import 'package:coindcxclone/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';

class PricesPage extends StatelessWidget {
  const PricesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<DisplayCoin> coins = List.generate(20, (index) {
      return const DisplayCoin(
          name: "Avalanche",
          tag: "AVAX",
          icon: "assets/images/avax.png",
          price: 5411.37,
          gain: 7.78);
    });
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  "Prices",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: SizedBox(
                  height: 80,
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: AssetImage("assets/images/prices_header.jpeg"),
                      ),
                    ),
                  ),
                ),
              ),
              Material(
                elevation: 3,
                child: TabBar(
                  indicatorColor: Colors.blue.shade800,
                  tabs: const [
                    Tab(
                      child: Text("My Watchlist"),
                    ),
                    Tab(
                      child: Text("All Coins"),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                  // height: 500,
                  child: TabBarView(
                    children: [
                      UserWatchList(coins: coins),
                      const Center(child: Text("All Coins!")),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: const DefaultNavigationBar(
          currentIndex: 1,
        ),
      ),
    );
  }
}
