import 'package:coindcxclone/utils/enums/trans_mode.dart';
import 'package:coindcxclone/utils/models/coin.dart';

class Order {
  final Coin coin;
  final TransactionMode mode;
  final num quantity;

  Order(this.coin, this.mode, this.quantity);
}
