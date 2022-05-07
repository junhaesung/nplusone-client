import 'package:flutter/material.dart';
import 'package:nplusone/view/navigation/bottom_tab_bar.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('검색'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Container(),
      bottomNavigationBar: const BottomTabBar(),
    );
  }
}
