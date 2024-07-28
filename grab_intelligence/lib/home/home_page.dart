import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grab_intelligence/detail_merchant/detail_merch_page.dart';
import 'package:grab_intelligence/home/model_restaurants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});
  

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ModelRestaurants? listOfRestaurants;
  String userName = 'User';
  String? userId;

  @override
  void initState() {
    super.initState();
    _getRestaurants();
    _getUserLocal();
  }

  void _getUserLocal() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('uid');
  }  

  void _getRestaurants() async {
    var url = Uri.https('angelhack.gremlinflat.com', '/api/list_restaurants');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      final endDecRes = json.decode(response.body);
      setState(() {
        listOfRestaurants = ModelRestaurants.fromJson(endDecRes);
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(40),
          ),
        ),
        backgroundColor: const Color.fromRGBO(0, 180, 94, 1),
        toolbarHeight: 100,
        centerTitle: false,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.account_circle_outlined,
                  color: Colors.white,
                ),
                const SizedBox(width: 10),
                Text(
                  'Hi $userName!',
                  style: const TextStyle(color: Colors.white),
                )
              ],
            ),
            const SizedBox(height: 10),
            TextFormField(
              autofocus: false,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    _getRestaurants();
                  },
                  icon: const Icon(Icons.search),
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Search Food',
                contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
      ),
      body: (() {
        if (listOfRestaurants == null) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return GridView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: listOfRestaurants?.data?.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              final itemName = listOfRestaurants!.data?[index].name ?? '-';
              final itemImage = listOfRestaurants?.data?[index].imageUrl;
              final itemIsHealthy = listOfRestaurants?.data?[index].isOk;
              return GestureDetector(
                onTap: (() {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailPageMerchant(merchantId: 'merchantId', merchantName: 'merchantName'),));
                }),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Image.network(itemImage!),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 150,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 130,
                              child: Text(
                                itemName,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            if(itemIsHealthy == true)...[
                              const SizedBox(width: 5),
                              Image.asset(
                                'assets/logo/healthy_check.png',
                                scale: 1.5,
                              )
                            ]
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 150,
                        child: Divider(),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      }()),
    );
  }
}