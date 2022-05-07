import 'package:flutter/material.dart';
import 'package:nplusone/view/navigation/bottom_tab_bar.dart';

class SettingView extends StatelessWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
      ),
      body: Container(),
      bottomNavigationBar: const BottomTabBar(),
    );
  }
}