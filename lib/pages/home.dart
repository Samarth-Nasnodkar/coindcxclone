import 'package:coindcxclone/widgets/advert_card.dart';
import 'package:coindcxclone/widgets/navigation_bar.dart';
import 'package:coindcxclone/widgets/newly_launched.dart';
import 'package:coindcxclone/widgets/top_gainers.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(
                  child: Text(
                    "Hi Samarth 👋",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                AdvertCard(),
                NewlyLaunched(),
                TopGainers(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const DefaultNavigationBar(
        currentIndex: 0,
      ),
    );
  }
}
