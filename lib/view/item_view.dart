import 'package:flutter/material.dart';
import 'package:nplusone/view/navigation/bottom_tab_bar.dart';

class ItemView extends StatelessWidget {
  const ItemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('상품'),
      ),
      body: Container(),
      bottomNavigationBar: const BottomTabBar(),
    );
  }
}