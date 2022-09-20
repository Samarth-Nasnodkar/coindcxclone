import 'package:coindcxclone/utils/models/coin.dart';
import 'package:coindcxclone/widgets/coin_pop_up.dart';
import 'package:coindcxclone/widgets/wl_dr.dart';
import 'package:flutter/material.dart';

class CoinsList extends StatelessWidget {
  final List<Coin> coins;

  const CoinsList({Key? key, required this.coins}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<DataRow> coinRows = List.generate(coins.length, (index) {
      String ps = (coins[index].gain > 0) ? '+' : '-';
      return DataRow(cells: [
        DataCell(
          WLDataRowCoin(coin: coins[index]),
          onTap: () {
            showBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) {
                return CoinPopUp(coin: coins[index]);
              },
            );
          },
          // placeholder: true,
        ),
        DataCell(
          Text(
            "₹${coins[index].price}",
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        DataCell(
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: SizedBox(
              height: 30,
              width: 70,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: (coins[index].gain < 0)
                      ? Colors.red.shade100
                      : Colors.green.shade100,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0, top: 3),
                  child: Text(
                    "$ps${coins[index].gain.abs()}%",
                    style: TextStyle(
                      // backgroundColor: Colors.red.shade100,
                      color:
                          (coins[index].gain >= 0) ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ]);
    });
    return SingleChildScrollView(
      child: DataTable(
        dataRowHeight: 60,
        columnSpacing: 0,
        headingTextStyle: TextStyle(
          color: Theme.of(context).textTheme.caption?.color,
          fontSize: 12,
        ),
        headingRowHeight: 45,
        columns: const [
          DataColumn(
            label: Text("COIN NAME"),
          ),
          DataColumn(
            label: Text("PRICE"),
          ),
          DataColumn(
            label: Text("24H CHANGE"),
          ),
        ],
        rows: coinRows,
      ),
    );
  }
}
