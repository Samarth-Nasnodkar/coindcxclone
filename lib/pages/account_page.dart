import 'package:coindcxclone/widgets/navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  Future logOut() async {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            logOut();
            Navigator.pushReplacementNamed(context, "main");
          },
          child: Center(
            child: Container(
              height: 70,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.blue,
              ),
              child: const Center(
                child: Text(
                  'Log Out',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const DefaultNavigationBar(currentIndex: 4),
    );
  }
}
