import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coindcxclone/utils/enums/trans_mode.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../utils/models/coin.dart';
import '../../utils/purchase.dart';

class InstantOrders extends StatefulWidget {
  final List<Purchase> orders;

  const InstantOrders({Key? key, required this.orders}) : super(key: key);

  @override
  State<InstantOrders> createState() => _InstantOrdersState();
}

class _InstantOrdersState extends State<InstantOrders> {
  Stream<Coin> readCoin(String coinTag) {
    return FirebaseFirestore.instance
        .collection('coins')
        .doc(coinTag)
        .snapshots()
        .map((event) => Coin.fromMap(event.data()!));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.orders.length,
      itemBuilder: (context, index) {
        Purchase order = widget.orders[index];

        return StreamBuilder<Coin>(
            stream: readCoin(order.coin),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator.adaptive(),
                  ),
                );
              }
              Coin _coin = snapshot.data!;
              return Column(
                children: [
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: SizedBox(
                          height: 40,
                          width: 40,
                          child: Image.asset(_coin.icon),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 80.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              (order.mode == TransactionMode.buy)
                                  ? "BUY"
                                  : "SELL",
                              style: TextStyle(
                                color: (order.mode == TransactionMode.buy)
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              _coin.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${DateFormat.yMMMd().format(order.dt)}, ${DateFormat.jm().format(order.dt)}',
                              style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.caption?.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Qty ${order.quantity} ${_coin.tag}",
                              style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.caption?.color,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Price ₹${order.purchasePrice}",
                              style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.caption?.color,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            RichText(
                              text: TextSpan(
                                  text: "Total",
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .caption
                                        ?.color,
                                    fontSize: 14,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          " ₹${double.parse((order.purchasePrice * order.quantity).toStringAsFixed(2))}",
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    )
                                  ]),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                ],
              );
            });
      },
    );
  }
}
