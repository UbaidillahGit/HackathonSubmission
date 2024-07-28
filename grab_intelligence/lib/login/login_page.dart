
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grab_intelligence/user_pref/user_pref_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
 late final FirebaseAuth firebaseAuth;
 
  void _googleSignIn(BuildContext context) async {
    final GoogleSignInAccount? googleUser;
    googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final userCred = await FirebaseAuth.instance.signInWithCredential(credential);
    // log('_googleSignIn ${googleUser?.id} | accessToken $credential');
    // log('userCred $userCred');
      // await prefs.setString('action', 'Start');

    if (userCred.credential != null && context.mounted && googleUser != null) {
      _saveUserLocalCahce(googleUser.id, googleUser.displayName ?? '-');
      final usersRefCol = FirebaseFirestore.instance.collection('users');
      usersRefCol.doc(googleUser.id).set(
        {
          'username': googleUser.displayName,
          'uid': googleUser.id,
        },
      );
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => UserPreferencesPage(
            uid: googleUser!.id,
          ),
        ),
      );
    }
  }

  void _saveUserLocalCahce(String uid, String username) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('uid', uid);
    await prefs.setString('username', username);
    log('_saveUserLocalCahce $uid');
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 30),
          Image.asset('assets/logo/grab_logo.png'),
          const SizedBox(height: 30),
          Image.asset('assets/images/login_banner.png'),
          const SizedBox(height: 20),
          const Text(
            'Transform Your',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const Text('Plate Wellness',style: TextStyle(
            fontSize: 15
          ),),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(0, 180, 94, 1),
                minimumSize: const Size(double.maxFinite, 50),
              ),
              onPressed: () => _googleSignIn(context),
              child: const Text(
                'SignIn with Google',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}