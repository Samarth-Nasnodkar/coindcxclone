import 'package:coindcxclone/utils/models/coin_data.dart';
import 'package:coindcxclone/utils/models/investments.dart';
import 'package:coindcxclone/widgets/coin_card.dart';
import 'package:flutter/material.dart';

import '../utils/models/coin.dart';

class NewlyLaunched extends StatelessWidget {
  const NewlyLaunched({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CoinCard> coins = List.generate(CoinData.coins.length, (index) {
      return CoinCard(
        coin: CoinData.coins[index],
      );
    });
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
            "Explore more assts for your portfoliio.",
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
                  child: coins[index],
                  onTap: () {
                    showBottomSheet(
                      context: context,
                      builder: (ctx) {
                        return Container(
                          decoration: const BoxDecoration(
                            color: Colors.white38,
                          ),
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Coin _coin = coins[index].coin;
                                    Investments.invens.add(
                                      _coin,
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: const Duration(seconds: 2),
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
                                    Coin _coin = coins[index].coin;
                                    bool removed =
                                        Investments.invens.remove(_coin);
                                    String message =
                                        '${_coin.name} Removed from Investments';
                                    if (!removed) {
                                      message =
                                          'You do not own any ${_coin.name}';
                                    }
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: const Duration(seconds: 2),
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
