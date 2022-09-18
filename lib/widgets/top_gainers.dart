import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coindcxclone/utils/models/coin_data.dart';
import 'package:coindcxclone/widgets/coin_card.dart';
import 'package:flutter/material.dart';

import '../utils/models/coin.dart';
import '../utils/models/investments.dart';

class TopGainers extends StatefulWidget {
  const TopGainers({Key? key}) : super(key: key);

  @override
  State<TopGainers> createState() => _TopGainersState();
}

class _TopGainersState extends State<TopGainers> {
  Stream<QuerySnapshot<Map<String, dynamic>>> readCoins() =>
      FirebaseFirestore.instance.collection('coins').snapshots();

  @override
  Widget build(BuildContext context) {
    // List<CoinCard> coins = List.generate(CoinData.coins.length, (index) {
    //   return CoinCard(
    //     coin: CoinData.coins[index],
    //   );
    // });
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: readCoins(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox(
              height: 100,
              width: 100,
              child: CircularProgressIndicator.adaptive(),
            );
          }
          final __coins =
              snapshot.data?.docs.map((e) => Coin.fromMap(e.data())).toList();
          List<Coin> coins = __coins!;
          coins.sort(
            (a, b) {
              return ((b.gain - a.gain) * 100).round();
            },
          );
          return Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "Top Gainers",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Coins that have gained the most in 24 hours.",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: coins.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          showBottomSheet(
                            context: context,
                            builder: (ctx) {
                              return Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white38,
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    // crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Coin _coin = coins[index];
                                          Investments.invens.add(
                                            _coin,
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              duration:
                                                  const Duration(seconds: 2),
                                              content: Text(
                                                '${_coin.name} Added to Investments',
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 100,
                                          decoration: const BoxDecoration(
                                            color: Colors.blue,
                                          ),
                                          child: const Center(
                                            child: Text(
                                              'BUY',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Coin _coin = coins[index];
                                          bool removed =
                                              Investments.invens.remove(_coin);
                                          String message =
                                              '${_coin.name} Removed from Investments';
                                          if (!removed) {
                                            message =
                                                'You do not own any ${_coin.name}';
                                          }
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              duration:
                                                  const Duration(seconds: 2),
                                              content: Text(
                                                message,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 100,
                                          decoration: const BoxDecoration(
                                            color: Colors.red,
                                          ),
                                          child: const Center(
                                            child: Text(
                                              'SELL',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: CoinCard(coin: coins[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}
