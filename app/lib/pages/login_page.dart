import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<void> signInWithGoogle() async {
    //googleでsign in
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
              child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // メッセージ
                Image.asset(
                  'assets/images/iconnect2.png',
                  height: 120,
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  'Welcome to "Iput connections"',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Let's connect with 'iput' student",
                  style: TextStyle(fontSize: 16),
                ),

                SizedBox(
                  height: 62,
                ),

                //ユーザー登録ボタン
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80.0),
                  child: GestureDetector(
                    onTap: () async {
                      await signInWithGoogle();
                    },
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Colors.blue[700],
                          borderRadius: BorderRadius.circular(24)),
                      child: Center(
                          child: Text(
                        'googleでログイン',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                    ),
                  ),
                ),
              ],
            ),
          )),
        ));
  }
}
