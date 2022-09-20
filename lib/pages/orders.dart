import 'package:coindcxclone/pages/tabs/instant_orders.dart';
import 'package:coindcxclone/utils/models/order.dart';
import 'package:coindcxclone/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';

class Orders extends StatelessWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Order> orders = [];
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  "Orders",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Material(
                elevation: 3,
                child: TabBar(
                  indicatorColor: Colors.blue.shade800,
                  tabs: const [
                    Tab(
                      child: Text("Instant"),
                    ),
                    Tab(
                      child: Text("Limit"),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                  child: TabBarView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: InstantOrders(orders: orders),
                      ),
                      const Center(
                        child: Text("Limit"),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: const DefaultNavigationBar(
          currentIndex: 2,
        ),
      ),
    );
  }
}
