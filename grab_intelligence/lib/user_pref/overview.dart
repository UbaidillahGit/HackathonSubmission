import 'package:flutter/material.dart';
import 'package:grab_intelligence/home/home_page.dart';

class UserPreferencesOverview extends StatefulWidget {
  const UserPreferencesOverview({super.key});

  @override
  State<UserPreferencesOverview> createState() => _UserPreferencesOverviewState();
}

class _UserPreferencesOverviewState extends State<UserPreferencesOverview> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Image.asset('assets/logo/grab_logo.png'),
            const SizedBox(height: 30),
            // Image.asset('assets/images/login_banner.png'),
            const SizedBox(height: 20),
            const Text(
              'Hi Joselyn!',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
            ),
            const SizedBox(height: 20),
            const Text(
              'Here is a summary of your preferences. You can go back to edit them now or save your selections. You can also update your preferences in your profile later.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), color: Colors.red),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'Halal Preference',
                      style: TextStyle(fontSize: 20),
                    ),
                    Row(
                      children: [],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), color: Colors.red),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'Vegan Preference',
                      style: TextStyle(fontSize: 20),
                    ),
                    Row(
                      children: [],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), color: Colors.red),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'History of Illness',
                      style: TextStyle(fontSize: 20),
                    ),
                    Row(
                      children: [],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), color: Colors.red),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'Food Alergies',
                      style: TextStyle(fontSize: 20),
                    ),
                    Row(
                      children: [],
                    )
                  ],
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(0, 180, 94, 1),
                elevation: 0,
                minimumSize: const Size(double.maxFinite, 50),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const HomePage();
                    },
                  ),
                );
              },
              child: const Text(
                'Save',
                style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w300),
              ),
            )
          ],
        ),
      ),
    );
  }
}
