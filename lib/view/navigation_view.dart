import 'package:flutter/material.dart';

import 'category_view.dart';
import 'search_view.dart';
import 'setting_view.dart';

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
      const Text('카테고리'),
      const Text('검색'),
      const Text('설정'),
    ]);
    _views.addAll([
      const CategoryView(),
      const SearchView(),
      const SettingView(),
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
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
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

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}