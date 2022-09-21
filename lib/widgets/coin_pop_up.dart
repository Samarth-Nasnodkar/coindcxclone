import 'dart:ui';

import 'package:coindcxclone/utils/storage_manager.dart';
import 'package:coindcxclone/widgets/price_chart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/models/coin.dart';

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
                        String email =
                            FirebaseAuth.instance.currentUser!.email!;
                        StorageManager()
                            .addInvestment(email, coin.tag, coin.price);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(seconds: 2),
                            content: Text(
                              'Coin added to investments successfully',
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
                      onTap: () async {
                        String email =
                            FirebaseAuth.instance.currentUser!.email!;
                        bool removed = await StorageManager()
                            .removeInvestment(email, coin.tag, coin.price);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: const Duration(seconds: 2),
                            content: Text(
                              removed
                                  ? 'Coin removed from investments successfully'
                                  : 'You don\'t own this coin',
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
