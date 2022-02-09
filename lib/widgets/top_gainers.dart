import 'package:coindcxclone/utils/models/coin_data.dart';
import 'package:coindcxclone/widgets/coin_card.dart';
import 'package:flutter/material.dart';

class TopGainers extends StatelessWidget {
  const TopGainers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CoinCard> coins = List.generate(10, (index) {
      return CoinCard(
        coin: CoinData.coins[0],
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
                return coins[index];
              },
            ),
          ),
        ],
      ),
    );
  }
}
