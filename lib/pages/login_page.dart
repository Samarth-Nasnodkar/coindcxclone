import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  Future logIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 100.0,
          left: 15.0,
          right: 15.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Login',
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                'Email address',
                style: TextStyle(
                  color: Color.fromARGB(221, 34, 34, 34),
                  fontSize: 17,
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'name@email.com',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                'Password',
                style: TextStyle(
                  color: Color.fromARGB(221, 34, 34, 34),
                  fontSize: 17,
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextField(
              obscureText: true,
              controller: passController,
              decoration: InputDecoration(
                hintText: '••••••',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            GestureDetector(
              onTap: logIn,
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
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, "signup");
              },
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                  text: 'Don\'t have an account? ',
                  children: [
                    TextSpan(
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                      text: 'Sign Up',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
