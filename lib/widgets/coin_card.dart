import 'package:coindcxclone/utils/models/coin.dart';
import 'package:flutter/material.dart';

class CoinCard extends StatelessWidget {
  final Coin coin;

  const CoinCard({Key? key, required this.coin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String gainSign = (coin.gain > 0) ? "+" : "-";
    Color gainColor = (coin.gain > 0) ? Colors.green : Colors.red;
    return SizedBox(
      height: 180,
      width: 150,
      child: Card(
        // rgba(246,248,248,255)
        // color: DefaultTheme(context).coinCardColor,
        elevation: 1,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 0, 5),
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(coin.icon),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  coin.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "₹${coin.price}",
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "$gainSign${coin.gain.abs()}%",
                  style: TextStyle(
                    fontSize: 22,
                    color: gainColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            // color: const Color.fromRGBO(246, 248, 248, 255),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
