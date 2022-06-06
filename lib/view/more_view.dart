import 'package:flutter/material.dart';
import 'package:nplusone/view/navigation/bottom_tab_bar.dart';

class MoreView extends StatelessWidget {
  const MoreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('더보기'),
      ),
      body: Container(),
      bottomNavigationBar: const BottomTabBar(),
    );
  }
}