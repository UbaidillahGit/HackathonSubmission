import 'package:flutter/material.dart';
import 'package:grab_intelligence/detail_merchant/detail_menu_page.dart';
import 'package:grab_intelligence/home/model_restaurants.dart';

class DetailPageMerchant extends StatefulWidget {
  const DetailPageMerchant({super.key, required this.data});
  final Data data;

  @override
  State<DetailPageMerchant> createState() => _DetailPageMerchantState();
}

class _DetailPageMerchantState extends State<DetailPageMerchant>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _recommendedTag() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset('assets/images/recommended_tag.png'),
        Positioned(bottom: 15, child: Image.asset('assets/images/ic_lamp.png'))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: null,
        body: Column(
          children: [
            Stack(
              children: [
                Image.network(widget.data.imageUrl!),
                Transform.translate(
                  offset: const Offset(100, 400),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey, width: 0.2),
                    ),
                    child: Text(widget.data.name ?? '-'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 450,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Card(
                    color: Colors.white,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(widget.data.imageUrl!, scale: 5.5),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 200,
                              child: Text(
                                widget.data.menus?[index].name ?? '-',
                                style: const TextStyle(fontSize: 18, color: Colors.black, overflow: TextOverflow.clip),
                              ),
                            ),
                            Text(
                              widget.data.menus?[index].price ?? '-',
                              style: const TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        if (index == 0 || index == 1) ...[
                          const Spacer(),
                          Transform.translate(
                            offset: const Offset(-10, -38),
                            child: _recommendedTag(),
                          ),
                        ]
                      ],
                    ),
                  ),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DetailMenuPage(menus: widget.data.menus![index], imgUrl: widget.data.imageUrl!),
                      ),
                    ),
                  );
                },
                itemCount: widget.data.menus?.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}