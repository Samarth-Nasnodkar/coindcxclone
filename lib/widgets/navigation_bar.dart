import 'package:flutter/material.dart';

class DefaultNavigationBar extends StatelessWidget {
  final int currentIndex;
  const DefaultNavigationBar({Key? key, required this.currentIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> labels = ["home", "prices", "orders", "inv", "acc"];
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      unselectedFontSize: 8,
      selectedFontSize: 8,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "HOME",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart_outlined),
          label: "PRICES",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.compare_arrows_rounded),
          label: "ORDERS",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet),
          label: "MY INVESTMENTS",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "ACCOUNT",
        ),
      ],
      onTap: (index) {
        if (index != 0) {
          Navigator.pushReplacementNamed(context, labels[index]);
        } else {
          // Navigator.pop(context);
          Navigator.pushReplacementNamed(context, 'home');
        }
      },
    );
  }
}
