import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coindcxclone/pages/tabs/all_coins.dart';
import 'package:coindcxclone/pages/tabs/watchlist.dart';
import 'package:coindcxclone/utils/models/coin.dart';
import 'package:coindcxclone/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';

class PricesPage extends StatefulWidget {
  const PricesPage({Key? key}) : super(key: key);

  @override
  State<PricesPage> createState() => _PricesPageState();
}

class _PricesPageState extends State<PricesPage> with WidgetsBindingObserver {
  bool darkMode = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    setState(() {
      darkMode =
          WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readCoins() =>
      FirebaseFirestore.instance.collection('coins').snapshots();

  @override
  Widget build(BuildContext context) {
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
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () {
                    // Will do it later.
                  },
                  child: SizedBox(
                    height: 50,
                    child: Container(
                      child: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            "Search coins to invest...",
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: (darkMode) ? null : const Color(0xfff5f5f5),
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(5),
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
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: readCoins(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: CircularProgressIndicator.adaptive(),
                          ),
                        );
                      }
                      final coins = snapshot.data!.docs
                          .map((e) => Coin.fromMap(e.data()))
                          .toList();
                      // List<Coin> coins = __coins;
                      return TabBarView(
                        children: [
                          UserWatchList(coins: coins),
                          AllCoins(coins: coins),
                        ],
                      );
                    },
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
