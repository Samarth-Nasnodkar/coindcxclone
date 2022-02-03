import 'package:coindcxclone/widgets/coin_card.dart';
import 'package:flutter/material.dart';

class NewlyLaunched extends StatelessWidget {
  const NewlyLaunched({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CoinCard> coins = List.generate(10, (index) {
      return const CoinCard(
          icon: "assets/images/avax.png",
          name: "Avalanche",
          price: 5801.14,
          gain: 4.34);
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
                return coins[index];
              },
            ),
          ),
        ],
      ),
    );
  }
}
