import 'package:coindcxclone/utils/enums/trans_mode.dart';

class Purchase {
  final TransactionMode mode;
  final DateTime dt;
  final num quantity;

  Purchase(this.mode, this.dt, this.quantity);

  num tranMode() {
    return mode == TransactionMode.buy ? 0 : 1;
  }

  Map<String, dynamic> toJSON() => {
        'mode': tranMode(),
        'dt': dt,
        'quantity': quantity,
      };

  static Purchase fromJSON(Map<String, dynamic> json) => Purchase(
        json['mode'],
        json['dt'],
        json['quantity'],
      );
}
