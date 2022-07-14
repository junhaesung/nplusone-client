import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import 'home_view.dart';
import 'search_view.dart';
import 'item_view.dart';
import 'more_view.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  var _selectedIndex = 0;
  final List<Widget> _titles = [];
  final List<Widget> _views = [];

  @override
  void initState() {
    super.initState();

    _titles.addAll([
      const Text('홈'),
      const Text('검색'),
      const Text('상품'),
      const Text('더보기'),
    ]);
    _views.addAll([
      const HomeView(),
      const SearchView(),
      const ItemView(),
      const MoreView(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _titles[_selectedIndex],
      ),
      body: _views[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            label: 'Item',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz_outlined),
            label: 'More',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }

  _onItemTapped(int index) async {
    await FirebaseAnalytics.instance
        .setCurrentScreen(
        screenName: index == 0 ? 'Home'
            : index == 1 ? 'Search'
            : index == 2 ? 'Item'
            : "More"
    );
    setState(() {
      _selectedIndex = index;
    });
  }
}