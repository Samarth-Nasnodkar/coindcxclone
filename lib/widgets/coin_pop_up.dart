import 'dart:ui';

import 'package:coindcxclone/widgets/price_chart.dart';
import 'package:flutter/material.dart';

import '../utils/models/coin.dart';
import '../utils/models/investments.dart';

class CoinPopUp extends StatelessWidget {
  const CoinPopUp({
    Key? key,
    required this.coin,
  }) : super(key: key);

  final Coin coin;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 6,
        sigmaY: 6,
      ),
      child: Container(
        decoration: const BoxDecoration(
          // color: Colors.transparent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 80.0,
              bottom: 20.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PriceChart(coinName: coin.tag),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Coin _coin = coins[index];
                        Investments.invens.add(
                          coin,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: const Duration(seconds: 2),
                            content: Text(
                              '${coin.name} Added to Investments',
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
                        Coin _coin = coin;
                        bool removed = Investments.invens.remove(_coin);
                        String message =
                            '${_coin.name} Removed from Investments';
                        if (!removed) {
                          message = 'You do not own any ${_coin.name}';
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
