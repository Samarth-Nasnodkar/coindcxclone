import 'package:cloud_firestore/cloud_firestore.dart';

class StorageManager {
  StorageManager();

  Future createUser(String name, String email) async {
    final doc = FirebaseFirestore.instance.collection('users').doc(email);

    final data = {
      'username': name,
      'email': email,
      'purchases': [],
    };

    await doc.set(data);
  }
}
