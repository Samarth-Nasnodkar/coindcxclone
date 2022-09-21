import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coindcxclone/pages/tabs/instant_orders.dart';
import 'package:coindcxclone/utils/purchase.dart';
import 'package:coindcxclone/widgets/navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  Stream<List<dynamic>> readPurchases() {
    String email = FirebaseAuth.instance.currentUser!.email!;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .snapshots()
        .map((event) => event.data()!['purchases']);
  }

  @override
  Widget build(BuildContext context) {
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
                        child: StreamBuilder<List<dynamic>>(
                          stream: readPurchases(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const SizedBox(
                                height: 100,
                                width: 100,
                                child: CircularProgressIndicator.adaptive(),
                              );
                            }
                            List<Purchase> orders = snapshot.data!
                                .map((e) => Purchase.fromJSON(e))
                                .toList();
                            return InstantOrders(orders: orders);
                          },
                        ),
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
