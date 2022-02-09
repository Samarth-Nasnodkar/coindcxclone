import 'package:coindcxclone/utils/models/coin.dart';
import 'package:flutter/material.dart';

class WLDataRowCoin extends StatelessWidget {
  final Coin coin;
  const WLDataRowCoin({Key? key, required this.coin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 50 / 100,
      height: MediaQuery.of(context).size.height * 10 / 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: SizedBox(
              child: Image.asset(coin.icon),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                coin.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                coin.tag,
                style: TextStyle(
                  color: Theme.of(context).textTheme.caption?.color,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
