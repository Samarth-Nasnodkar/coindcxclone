import 'package:coindcxclone/widgets/display_coin.dart';
import 'package:coindcxclone/widgets/wl_dr.dart';
import 'package:flutter/material.dart';

class UserWatchList extends StatelessWidget {
  final List<DisplayCoin> coins;
  const UserWatchList({Key? key, required this.coins}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<DataRow> coinRows = List.generate(coins.length, (index) {
      return DataRow(cells: [
        DataCell(
          WLDataRowCoin(coin: coins[index]),
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
                  color: Colors.red.shade100,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0, top: 3),
                  child: Text(
                    "+${coins[index].gain}%",
                    style: const TextStyle(
                      // backgroundColor: Colors.red.shade100,
                      color: Colors.red,
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
