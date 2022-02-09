import 'package:coindcxclone/widgets/coins_list.dart';
import 'package:coindcxclone/utils/models/coin.dart';
import 'package:flutter/material.dart';

class AllCoins extends StatelessWidget {
  final List<Coin> coins;

  const AllCoins({Key? key, required this.coins}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CoinsList(coins: coins);
  }
}
