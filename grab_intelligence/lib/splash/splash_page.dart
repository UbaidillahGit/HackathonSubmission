import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:grab_intelligence/home/home_page.dart';
import 'package:grab_intelligence/login/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String? uid;
  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  void _checkSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    uid = prefs.getString('uid');
    _routingBySession(uid);
    log('_checkSession $uid');
  }

  void _routingBySession(String? uid) {
    if (uid == null) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
        (route) => false,
      );
    }

    if (uid != null) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/logo/splash_logo.png',
            scale: 2,
          ),
          const SizedBox(
            height: 60,
          ),
          const CircularProgressIndicator()
        ],
      ),
    );
  }
}
