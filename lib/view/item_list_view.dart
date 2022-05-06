import 'package:flutter/material.dart';

class ItemListView extends StatelessWidget {
  const ItemListView({Key? key, required this.storeName}) : super(key: key);
  final String storeName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(storeName)
      ),
      body: Container(),
    );
  }
}