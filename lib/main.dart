import 'package:coindcxclone/pages/account_page.dart';
import 'package:coindcxclone/pages/home.dart';
import 'package:coindcxclone/pages/login_page.dart';
import 'package:coindcxclone/pages/main_page.dart';
import 'package:coindcxclone/pages/orders.dart';
import 'package:coindcxclone/pages/prices.dart';
import 'package:coindcxclone/pages/signup_page.dart';
import 'package:coindcxclone/pages/tabs/inv_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainPage(),
      routes: {
        "main": (context) => const MainPage(),
        "home": (context) => const HomePage(),
        "prices": (context) => const PricesPage(),
        "orders": (context) => const Orders(),
        "inv": (context) => const InvPage(),
        "acc": (context) => const AccountPage(),
        "signup": (context) => const SignupPage(),
        "signin": (context) => const LoginPage(),
      },
      themeMode: ThemeMode.system,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: GoogleFonts.sourceSans3().fontFamily,
        cardColor: null,
        inputDecorationTheme: const InputDecorationTheme(
          fillColor: null,
        ),
        tabBarTheme: TabBarTheme(
          labelStyle: const TextStyle(
            fontSize: 18,
          ),
          labelColor: Colors.blue.shade800,
          unselectedLabelStyle: const TextStyle(
            fontSize: 18,
          ),
          unselectedLabelColor: Colors.grey,
        ),
        textTheme: const TextTheme(
          bodyText2: TextStyle(
            color: Colors.white70,
            fontSize: 16,
          ),
        ),
      ),
      theme: ThemeData(
        canvasColor: Colors.white,
        fontFamily: GoogleFonts.sourceSans3().fontFamily,
        cardColor: const Color(0xfff5f5f5),
        inputDecorationTheme: const InputDecorationTheme(
          fillColor: Color(0xfff5f5f5),
        ),
        tabBarTheme: TabBarTheme(
          labelStyle: const TextStyle(
            fontSize: 18,
          ),
          labelColor: Colors.blue.shade800,
          unselectedLabelStyle: const TextStyle(
            fontSize: 18,
          ),
          unselectedLabelColor: Colors.grey,
        ),
        textTheme: const TextTheme(
          bodyText2: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
