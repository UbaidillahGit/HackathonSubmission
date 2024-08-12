import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grab_intelligence/home/home_page.dart';
import 'package:onboarding/onboarding.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class UserPreferencesPage extends StatefulWidget {
  const UserPreferencesPage({super.key, required this.uid});
  final String uid;

  @override
  State<UserPreferencesPage> createState() => _UserPreferencesPageState();
}

class _UserPreferencesPageState extends State<UserPreferencesPage> {
  int _onBoardingIdx = 0;
  PageController pageController = PageController(initialPage: 0);

  bool? isHalal;
  bool? isVegan;
  List<String> listOfAlergies = [];
  List<String> listOfIllness = [];

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
  }

  void _setHalal(bool val) => setState(() => isHalal = val);

  void _setVegan(bool val) => setState(() => isVegan = val);

  void _setIllness(String val) {
    setState(() {
      if (val == 'None' && !listOfIllness.contains('None')) {
        listOfIllness.clear();
        listOfIllness.add('None');
      }

      if (val != 'None') {
        if (listOfIllness.contains('None')) {
          listOfIllness.clear();
        }
        if (listOfIllness.contains(val)) {
          listOfIllness.remove(val);
        } else {
          listOfIllness.add(val);
        }
      }
    });
  }

  void _setAlergies(String val) {
    setState(
      () {
        if (val == 'None' && !listOfIllness.contains('None')) {
          listOfAlergies.clear();
          listOfAlergies.add('None');
        }

        if (val != 'None') {
          if (listOfAlergies.contains('None')) {
            listOfAlergies.clear();
          }
          if (listOfAlergies.contains(val)) {
            listOfAlergies.remove(val);
          } else {
            listOfAlergies.add(val);
          }
        }
      },
    );
  }

  void _saveUserPref() async {
    final restaurantRefCol = FirebaseFirestore.instance.collection('users').doc(widget.uid);
    final payload = {
      'isHalal': isHalal,
      'isVegan': isVegan,
      'historyOfAlergies': listOfAlergies,
      'historyOfIllness': listOfIllness,
    };
    restaurantRefCol.set(payload, SetOptions(merge: true));
    final res = await restaurantRefCol.get();

    if (res.exists) {
      _navigateToHome();
    }
    log('savePref ${res.id} | ${widget.uid}');
    log('payload $payload');
  }

  void _navigateToHome() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Onboarding(
        buildFooter: (context, netDragDistance, pagesLength, currentIndex, setIndex, slideDirection) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: AnimatedSmoothIndicator(
                      activeIndex: _onBoardingIdx,
                      count: 4,
                      effect: const WormEffect(activeDotColor: Color.fromRGBO(0, 180, 94, 1)),
                    ),
                  ),
                  const SizedBox(width: 50),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(0, 180, 94, 1),
                      elevation: 0,
                    ),
                    onPressed: () {
                      if (isHalal == true && isVegan == true && listOfAlergies.isNotEmpty && listOfAlergies.isNotEmpty) {
                        return _saveUserPref();
                      }
                      return;
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
        },
        startIndex: 0,
        onPageChanges: (netDragDistance, pagesLength, currentIndex, slideDirection) {
          setState(() {
            _onBoardingIdx = currentIndex;
          });
        },
        swipeableBody: [
          _widgetHalal(),
          _widgetVeganDiet(),
          _widgetHistoryOfIllness(),
          _widgetFoodAlergies(),
        ],
      ),
    );
  }

  Widget _widgetHalal() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Image.asset('assets/logo/grab_logo.png'),
          const SizedBox(height: 30),
          // Image.asset('assets/images/login_banner.png'),
          const SizedBox(height: 20),
          const Text(
            'Do You Prefer Halal Food?',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
          ),
          const SizedBox(height: 20),
          const Text(
            'Halal food follows Islamic dietary laws, ensuring all ingredients and preparation methods are permissible.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(0, 180, 94, 1),
              elevation: 0,
              minimumSize: const Size(
                double.maxFinite,
                50,
              ),
            ),
            onPressed: () {
              _setHalal(true);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Yes, I prefer halal food',
                  style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w300),
                ),
                if (isHalal != null && isHalal == true) ...[
                  const SizedBox(width: 10),
                  const Icon(
                    Icons.check_circle,
                    color: Colors.white,
                  )
                ]
              ],
            ),
          ),
          const SizedBox(height: 25),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(0, 180, 94, 1),
              elevation: 0,
              minimumSize: const Size(double.maxFinite, 50),
            ),
            onPressed: () => _setHalal(false),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'No, I don’t need halal food',
                  style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w300),
                ),
                if (isHalal != null && isHalal == false) ...[
                  const SizedBox(width: 10),
                  const Icon(
                    Icons.check_circle,
                    color: Colors.white,
                  )
                ]
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _widgetVeganDiet() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Image.asset('assets/logo/grab_logo.png'),
          const SizedBox(height: 30),
          // Image.asset('assets/images/login_banner.png'),
          const SizedBox(height: 20),
          const Text(
            'Do You Follow Vegan Diet?',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
          ),
          const SizedBox(height: 20),
          const Text(
            'Vegan diets exclude all animal products, including meat, dairy, and eggs. Choosing vegan options ensures that all your meals are plant-based.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(0, 180, 94, 1), elevation: 0, minimumSize: const Size(double.maxFinite, 50)),
            onPressed: () {
              _setVegan(true);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Yes, I follow a vegan diet',
                  style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w300),
                ),
                if (isVegan != null && isVegan == true) ...[
                  const SizedBox(width: 10),
                  const Icon(
                    Icons.check_circle,
                    color: Colors.white,
                  )
                ]
              ],
            ),
          ),
          const SizedBox(height: 25),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(0, 180, 94, 1),
              elevation: 0,
              minimumSize: const Size(double.maxFinite, 50),
            ),
            onPressed: () {
              _setVegan(false);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'No, I don’t follow a vegan diet',
                  style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w300),
                ),
                if (isVegan != null && isVegan == false) ...[
                  const SizedBox(width: 10),
                  const Icon(
                    Icons.check_circle,
                    color: Colors.white,
                  )
                ]
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _widgetHistoryOfIllness() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Image.asset('assets/logo/grab_logo.png'),
          const SizedBox(height: 30),
          const SizedBox(height: 20),
          const Text(
            'Do You Have a History of Illness ?',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
          ),
          const SizedBox(height: 20),
          const Text(
            'Please select any illnesses you have been diagnosed with. This information helps us tailor food recommendations to support your health needs.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(0, 180, 94, 1),
                    elevation: 0,
                    minimumSize: const Size(double.maxFinite, 50),
                  ),
                  onPressed: () {
                    log('onPressed ');
                    _setIllness('Hepatitis A');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Hepatitis A',
                        style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w300),
                      ),
                      const SizedBox(width: 10),
                      if (listOfIllness.contains('Hepatitis A')) ...[
                        const Icon(
                          Icons.check_circle,
                          color: Colors.white,
                        )
                      ]
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(0, 180, 94, 1),
                    elevation: 0,
                    minimumSize: const Size(double.maxFinite, 50),
                  ),
                  onPressed: () {
                    _setIllness('Hepatitis B');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Hepatitis B',
                        style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w300),
                      ),
                      if (listOfIllness.contains('Hepatitis B')) ...[
                        const Icon(
                          Icons.check_circle,
                          color: Colors.white,
                        )
                      ]
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(0, 180, 94, 1),
                    elevation: 0,
                    minimumSize: const Size(double.maxFinite, 50),
                  ),
                  onPressed: () {
                    _setIllness('Diabetes');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Diabetes',
                        style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w300),
                      ),
                      if (listOfIllness.contains('Diabetes')) ...[
                        const Icon(
                          Icons.check_circle,
                          color: Colors.white,
                        )
                      ]
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(0, 180, 94, 1),
                    elevation: 0,
                    minimumSize: const Size(double.maxFinite, 50),
                  ),
                  onPressed: () {
                    _setIllness('Hypertention');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Hypertention',
                        style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w300),
                      ),
                      if (listOfIllness.contains('Hypertention')) ...[
                        const Icon(
                          Icons.check_circle,
                          color: Colors.white,
                        )
                      ]
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(0, 180, 94, 1),
                    elevation: 0,
                    minimumSize: const Size(double.maxFinite, 50),
                  ),
                  onPressed: () {
                    _setIllness('None');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'None',
                        style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w300),
                      ),
                      if (listOfIllness.contains('None')) ...[
                        const Icon(
                          Icons.check_circle,
                          color: Colors.white,
                        )
                      ]
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _widgetFoodAlergies() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Image.asset('assets/logo/grab_logo.png'),
          const SizedBox(height: 30),
          // Image.asset('assets/images/login_banner.png'),
          const SizedBox(height: 20),
          const Text(
            'Do You Have Any Food Allergies ?',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
          ),
          const SizedBox(height: 20),
          const Text(
            'Please select any food allergies you have from the list below. This helps us avoid recommending foods that could trigger allergic reactions.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(0, 180, 94, 1),
                    elevation: 0,
                    minimumSize: const Size(double.maxFinite, 50),
                  ),
                  onPressed: () {
                    _setAlergies('Seafood');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Seafood',
                        style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w300),
                      ),
                      if (listOfAlergies.contains('Seafood')) ...[
                        const Icon(
                          Icons.check_circle,
                          color: Colors.white,
                        )
                      ]
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(0, 180, 94, 1),
                    elevation: 0,
                    minimumSize: const Size(double.maxFinite, 50),
                  ),
                  onPressed: () {
                    _setAlergies('Nuts');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Nuts',
                        style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w300),
                      ),
                      if (listOfAlergies.contains('Nuts')) ...[
                        const Icon(
                          Icons.check_circle,
                          color: Colors.white,
                        )
                      ]
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(0, 180, 94, 1),
                    elevation: 0,
                    minimumSize: const Size(double.maxFinite, 50),
                  ),
                  onPressed: () {
                    _setAlergies('Dairy Milk');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Dairy Milk',
                        style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w300),
                      ),
                      if (listOfAlergies.contains('Dairy Milk')) ...[
                        const Icon(
                          Icons.check_circle,
                          color: Colors.white,
                        )
                      ]
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(0, 180, 94, 1),
                    elevation: 0,
                    minimumSize: const Size(double.maxFinite, 50),
                  ),
                  onPressed: () {
                    _setAlergies('Chicken Eggs');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Chicken Eggs',
                        style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w300),
                      ),
                      if (listOfAlergies.contains('Chicken Eggs')) ...[
                        const Icon(
                          Icons.check_circle,
                          color: Colors.white,
                        )
                      ]
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(0, 180, 94, 1),
                    elevation: 0,
                    minimumSize: const Size(double.maxFinite, 50),
                  ),
                  onPressed: () {
                    _setAlergies('None');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'None',
                        style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w300),
                      ),
                      if (listOfAlergies.contains('None')) ...[
                        const Icon(
                          Icons.check_circle,
                          color: Colors.white,
                        )
                      ]
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}


