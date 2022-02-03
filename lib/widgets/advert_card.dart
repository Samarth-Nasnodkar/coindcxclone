import 'package:flutter/material.dart';

class AdvertCard extends StatelessWidget {
  const AdvertCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: MediaQuery.of(context).size.width * 92 / 100,
      height: 150,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Container(
          // child: Image.asset("assets/images/advert.png"),
          decoration: BoxDecoration(
            image: const DecorationImage(
              fit: BoxFit.fitWidth,
              image: AssetImage("assets/images/advert-2.png"),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
