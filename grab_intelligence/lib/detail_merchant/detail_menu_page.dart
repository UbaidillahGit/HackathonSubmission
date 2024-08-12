import 'package:flutter/material.dart';
import 'package:grab_intelligence/home/model_restaurants.dart';

class DetailMenuPage extends StatefulWidget {
  const DetailMenuPage({super.key, required this.menus, required this.imgUrl});
  final String imgUrl;
  final Menus menus;

  @override
  State<DetailMenuPage> createState() => _DetailMenuPageState();
}

class _DetailMenuPageState extends State<DetailMenuPage> {

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: null,
        body: Column(
          children: [
            Image.network(
              widget.imgUrl,
              height: 250,
              width: double.maxFinite,
              fit: BoxFit.fitWidth,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.menus.name ?? '-',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    '${widget.menus.price}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color.fromRGBO(0, 180, 94, 1), width: 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Recommended by ',
                      style: TextStyle(fontSize: 18),
                    ),
                    const Text(
                      'GrabHealthyEats',
                      style: TextStyle(fontSize: 18, color: Color.fromRGBO(0, 180, 94, 1)),
                    ),
                    const SizedBox(width: 5),
                    Image.asset(
                      'assets/logo/healthy_check.png',
                      scale: 1.5,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    shape: const CircleBorder(side: BorderSide(color: Color.fromRGBO(236, 239, 238, 1)))
                  ),
                  child: const Icon(
                    Icons.remove,
                    color: Color.fromRGBO(0, 180, 94, 1),
                  ),
                ),
                const Text('2', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    shape: const CircleBorder(side: BorderSide(color: Color.fromRGBO(236, 239, 238, 1)))
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Color.fromRGBO(0, 180, 94, 1),
                  ),
                ),
              ],
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(0, 180, 94, 1),
              minimumSize: const Size(double.maxFinite, 50)
            ),
            child: const Text(
              'Add to Basket - ${30.00} USD (incl. tax)',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18
              ),
            ),
          ),
        ),
      ),
    );
  }
}
