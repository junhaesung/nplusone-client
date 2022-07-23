import 'package:flutter/material.dart';
import 'package:nplusone/view/appbar/nplusone_app_bar.dart';
import 'package:nplusone/view/navigation/bottom_tab_bar.dart';

class MoreView extends StatelessWidget {
  const MoreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NplusoneAppBar.more(),
      body: Container(),
      bottomNavigationBar: const BottomTabBar(),
    );
  }
}