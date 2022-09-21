import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coindcxclone/utils/enums/trans_mode.dart';

class Purchase {
  final TransactionMode mode;
  final DateTime dt;
  num quantity;
  final num purchasePrice;
  final String coin;

  Purchase(this.mode, this.dt, this.quantity, this.coin, this.purchasePrice);

  num tranMode() {
    return mode == TransactionMode.buy ? 0 : 1;
  }

  Map<String, dynamic> toJSON() => {
        'mode': tranMode(),
        'dt': Timestamp.fromDate(dt),
        'quantity': quantity,
        'coin': coin,
        'pp': purchasePrice,
      };

  static Purchase fromJSON(Map<String, dynamic> json) => Purchase(
        TransactionMode.values[json['mode']],
        (json['dt'] as Timestamp).toDate(),
        json['quantity'],
        json['coin'],
        json['pp'],
      );
}
