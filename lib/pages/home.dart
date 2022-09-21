import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coindcxclone/widgets/advert_card.dart';
import 'package:coindcxclone/widgets/navigation_bar.dart';
import 'package:coindcxclone/widgets/newly_launched.dart';
import 'package:coindcxclone/widgets/top_gainers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/coin_user.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // loadData();
    // LocalCoinStorage().dumpFromNet();
  }

  Stream<CoinUser> readUsers() {
    String? email = FirebaseAuth.instance.currentUser?.email;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .snapshots()
        .map(
            (event) => CoinUser.fromJSON(event.data() as Map<String, dynamic>));
  }

  // loadData() async {
  //   if (CoinData.coins.isNotEmpty) return;
  //   var _data = await rootBundle.loadString("assets/data/coins.json");
  //   var _ddata = jsonDecode(_data);
  //   var _coins = _ddata["coins"];
  //   var l = _coins.length;
  //   CoinData.coins =
  //       List.generate(l, (index) => Coin.fromMap(_coins[index % l]));
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<CoinUser>(
        stream: readUsers(),
        builder: (context, snapshot) => (snapshot.hasData)
            ? SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: Text(
                            "Hi ${snapshot.data?.username} 👋",
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const AdvertCard(),
                        const NewlyLaunched(),
                        const TopGainers(),
                      ],
                    ),
                  ),
                ),
              )
            : const Center(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator.adaptive(),
                ),
              ),
      ),
      bottomNavigationBar: const DefaultNavigationBar(
        currentIndex: 0,
      ),
    );
  }
}
