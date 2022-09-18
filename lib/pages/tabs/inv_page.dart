import 'package:coindcxclone/utils/models/investments.dart';
import 'package:coindcxclone/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';

import '../../utils/models/coin.dart';

class InvPage extends StatefulWidget {
  const InvPage({Key? key}) : super(key: key);

  @override
  State<InvPage> createState() => _InvPageState();
}

class _InvPageState extends State<InvPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Investments.invens.isNotEmpty
          ? ListView.builder(
              itemBuilder: (ctx, index) {
                Coin _coin = Investments.invens[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _coin.name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Coin _coin = coins[index].coin;
                            Investments.invens.add(
                              _coin,
                            );
                            setState(() {});
                          },
                          child: Container(
                            height: 50,
                            width: 80,
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
                            // Coin _coin = coins[index].coin;
                            bool removed = Investments.invens.remove(_coin);
                            setState(() {});
                          },
                          child: Container(
                            height: 50,
                            width: 80,
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
                );
              },
              itemCount: Investments.invens.length,
            )
          : const Center(
              child: Text(
                'No Investmentes Yet!',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
      bottomNavigationBar: const DefaultNavigationBar(
        currentIndex: 3,
      ),
    );
  }
}
