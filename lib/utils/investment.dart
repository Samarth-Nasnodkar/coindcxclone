import 'package:coindcxclone/utils/purchase.dart';

class Investment {
  final Purchase purchase;

  Investment(this.purchase);

  static Investment fromJSON(Map<String, dynamic> json) =>
      Investment(Purchase.fromJSON(json));

  Map<String, dynamic> toJSON() => purchase.toJSON();
}
