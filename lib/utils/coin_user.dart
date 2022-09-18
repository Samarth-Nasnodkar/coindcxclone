import 'package:coindcxclone/utils/purchase.dart';

class CoinUser {
  final String username;
  final String email;
  final List<Purchase> purchases;

  CoinUser(this.username, this.email, this.purchases);

  Map<String, dynamic> toJSON() => {
        'username': username,
        'email': email,
        'purchases': List.generate(
          purchases.length,
          (index) => purchases[index].toJSON(),
        ),
      };

  static CoinUser fromJSON(Map<String, dynamic> json) => CoinUser(
        json['username'],
        json['email'],
        List.generate(
          json['purchases'].length,
          (index) => Purchase.fromJSON(json['purchases'][index]),
        ),
      );
}
