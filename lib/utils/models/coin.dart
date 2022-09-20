import 'package:cloud_firestore/cloud_firestore.dart';

class Coin {
  final String name, tag, icon;
  final DateTime top;
  final num price, gain;
  final List<dynamic> prices;
  const Coin({
    required this.top,
    required this.name,
    required this.tag,
    required this.icon,
    required this.price,
    required this.gain,
    required this.prices,
  });

  static Coin fromMap(Map<String, dynamic> data) {
    return Coin(
      name: data["name"],
      tag: data["tag"],
      icon: data["icon"],
      price: data["price"],
      gain: data["gain"],
      top: (data["top"] as Timestamp).toDate(),
      prices: data["prices"]
          .map(
            (e) => {
              'ts': e['ts'],
              'price': e['price'],
            },
          )
          .toList(),
    );
  }
}
