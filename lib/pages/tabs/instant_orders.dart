import 'package:coindcxclone/utils/enums/trans_mode.dart';
import 'package:coindcxclone/utils/models/order.dart';
import 'package:flutter/material.dart';

class InstantOrders extends StatelessWidget {
  final List<Order> orders;

  const InstantOrders({Key? key, required this.orders}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        Order order = orders[index];
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
                    child: Image.asset(order.coin.icon),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 80.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (order.mode == TransactionMode.buy) ? "BUY" : "SELL",
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
                        order.coin.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        order.coin.top,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.caption?.color,
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
                        "Qty ${order.quantity} ${order.coin.tag}",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.caption?.color,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Price ₹${order.coin.price}",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.caption?.color,
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
                              color: Theme.of(context).textTheme.caption?.color,
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                text: " ₹${order.coin.price * order.quantity}",
                                style: Theme.of(context).textTheme.bodyText2,
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
      },
    );
  }
}
