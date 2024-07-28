import 'package:flutter/material.dart';

class DetailPageMerchant extends StatefulWidget {
  const DetailPageMerchant({super.key, required this.merchantId, required this.merchantName});
  final String merchantId;
  final String merchantName;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.merchantName),
      ),
      body: Center(),
    );
  }
}