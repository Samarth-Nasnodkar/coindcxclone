import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coindcxclone/pages/tabs/instant_orders.dart';
import 'package:coindcxclone/utils/investment.dart';
import 'package:coindcxclone/widgets/inv_body.dart';
import 'package:coindcxclone/widgets/navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/models/coin.dart';

class InvPage extends StatefulWidget {
  const InvPage({Key? key}) : super(key: key);

  @override
  State<InvPage> createState() => _InvPageState();
}

class _InvPageState extends State<InvPage> {
  Stream<List<dynamic>> readInvs() {
    String email = FirebaseAuth.instance.currentUser!.email!;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .snapshots()
        .map((event) => event.data()!['inv']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<dynamic>>(
          stream: readInvs(),
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
            List<Investment> invs =
                snapshot.data!.map((e) => Investment.fromJSON(e)).toList();
            return InvBody(orders: invs.map((e) => e.purchase).toList());
          }),
      bottomNavigationBar: const DefaultNavigationBar(
        currentIndex: 3,
      ),
    );
  }
}
