class Coin {
  final String name, tag, icon, top;
  final num price, gain;
  const Coin(
      {required this.top,
      required this.name,
      required this.tag,
      required this.icon,
      required this.price,
      required this.gain});

  factory Coin.fromMap(Map<String, dynamic> data) {
    return Coin(
      name: data["name"],
      tag: data["tag"],
      icon: data["icon"],
      price: data["price"],
      gain: data["gain"],
      top: data["top"],
    );
  }
}
