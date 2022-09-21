import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coindcxclone/utils/enums/trans_mode.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../utils/models/coin.dart';
import '../../utils/purchase.dart';
import '../utils/storage_manager.dart';

class InvBody extends StatefulWidget {
  final List<Purchase> orders;

  const InvBody({Key? key, required this.orders}) : super(key: key);

  @override
  State<InvBody> createState() => _InvBodyState();
}

class _InvBodyState extends State<InvBody> {
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
                              "Price ₹${double.parse((order.purchasePrice).toStringAsFixed(2))}",
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
                                          " ₹${double.parse((_coin.price * order.quantity).toStringAsFixed(2))}",
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
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            String email =
                                FirebaseAuth.instance.currentUser!.email!;
                            StorageManager()
                                .addInvestment(email, order.coin, _coin.price);
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
                                .removeInvestment(
                                    email, order.coin, order.purchasePrice);
                            try {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: const Duration(milliseconds: 50),
                                  content: Text(
                                    removed
                                        ? 'Coin removed from investments successfully'
                                        : 'You don\'t own this coin',
                                  ),
                                ),
                              );
                            } on Exception catch (e) {
                              debugPrint('Flutter Error! $e');
                            }
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
