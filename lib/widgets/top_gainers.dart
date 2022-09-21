import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coindcxclone/widgets/coin_card.dart';
import 'package:coindcxclone/widgets/coin_pop_up.dart';
import 'package:flutter/material.dart';
import '../utils/models/coin.dart';

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
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (ctx) {
                              return CoinPopUp(coin: coins[index]);
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
