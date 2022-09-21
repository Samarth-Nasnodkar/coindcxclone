import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coindcxclone/utils/enums/trans_mode.dart';
import 'package:coindcxclone/utils/investment.dart';
import 'package:coindcxclone/utils/purchase.dart';

class StorageManager {
  StorageManager();

  Future createUser(String name, String email) async {
    final doc = FirebaseFirestore.instance.collection('users').doc(email);

    final data = {
      'username': name,
      'email': email,
      'purchases': [],
      'inv': [],
    };

    await doc.set(data);
  }

  Future addInvestment(String email, String coinTag, num currPrice) async {
    final doc = FirebaseFirestore.instance.collection('users').doc(email);
    final _pur =
        Purchase(TransactionMode.buy, DateTime.now(), 1, coinTag, currPrice)
            .toJSON();

    final userDataSnapshot = await doc.get();
    final userData = userDataSnapshot.data()!;

    List<dynamic> invs = userData['inv'];
    if (invs.isEmpty) {
      invs = [_pur];
      await doc.update({
        'inv': invs,
        'purchases': FieldValue.arrayUnion([
          _pur,
        ]),
      });
      return;
    }
    bool coinAlreadyPresent = false;
    for (int i = 0; i < invs.length; i++) {
      final inv = Investment.fromJSON(invs[i]);
      if (inv.purchase.coin == coinTag) {
        coinAlreadyPresent = true;
        inv.purchase.quantity += 1;
        invs[i] = inv.toJSON();
        break;
      }
    }
    if (!coinAlreadyPresent) {
      invs.add(_pur);
      await doc.update({
        'inv': invs,
        'purchases': FieldValue.arrayUnion([
          _pur,
        ]),
      });
    } else {
      await doc.update({
        'purchases': FieldValue.arrayUnion([
          _pur,
        ]),
        'inv': invs,
      });
    }
  }

  Future<bool> removeInvestment(
      String email, String coinTag, num currPrice) async {
    final doc = FirebaseFirestore.instance.collection('users').doc(email);

    final _pur =
        Purchase(TransactionMode.sell, DateTime.now(), 1, coinTag, currPrice)
            .toJSON();

    final userDataSnapshot = await doc.get();
    final userData = userDataSnapshot.data()!;

    List<dynamic> invs = userData['inv'];
    if (invs.isEmpty) {
      // invs = [_pur];
      // await doc.update({
      //   'inv': invs,
      //   'purchases': FieldValue.arrayUnion([
      //     _pur,
      //   ]),
      // });
      return false;
    }
    bool coinAlreadyPresent = false;
    for (int i = 0; i < invs.length; i++) {
      final inv = Investment.fromJSON(invs[i]);
      if (inv.purchase.coin == coinTag) {
        coinAlreadyPresent = true;
        inv.purchase.quantity -= 1;
        invs[i] = inv.toJSON();
        break;
      }
    }
    if (!coinAlreadyPresent) {
      // invs.add(_pur);
      // await doc.update({
      //   'inv': invs,
      //   'purchases': FieldValue.arrayUnion([
      //     _pur,
      //   ]),
      // });
      return false;
    } else {
      for (int i = 0; i < invs.length; i++) {
        if (invs[i]['quantity'] <= 0) {
          invs.removeAt(i);
        }
      }
      await doc.update({
        'purchases': FieldValue.arrayUnion([
          _pur,
        ]),
        'inv': invs,
      });
      return true;
    }
  }
}
