import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coindcxclone/widgets/coin_card.dart';
import 'package:flutter/material.dart';
import '../utils/models/coin.dart';
import 'coin_pop_up.dart';

class NewlyLaunched extends StatefulWidget {
  const NewlyLaunched({Key? key}) : super(key: key);

  @override
  State<NewlyLaunched> createState() => _NewlyLaunchedState();
}

class _NewlyLaunchedState extends State<NewlyLaunched> {
  Stream<QuerySnapshot<Map<String, dynamic>>> readCoins() =>
      FirebaseFirestore.instance.collection('coins').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: readCoins(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Coin>? __coins =
                snapshot.data?.docs.map((e) => Coin.fromMap(e.data())).toList();
            final coins = __coins!;
            return Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    "Newly launched on CoinDCX",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Explore more assets for your portfoliio.",
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
                          child: CoinCard(coin: coins[index]),
                          onTap: () {
                            showBottomSheet(
                              // elevation: 1.0,
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (ctx) {
                                return CoinPopUp(coin: coins[index]);
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox(
              height: 100,
              width: 100,
              child: CircularProgressIndicator.adaptive(),
            );
          }
        });
  }
}
