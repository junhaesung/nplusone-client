import 'package:flutter/material.dart';
import 'package:nplusone/view/appbar/nplusone_app_bar.dart';
import 'package:nplusone/view/navigation/bottom_tab_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NplusoneAppBar.home(),
      body: _getBody(),
      bottomNavigationBar: const BottomTabBar(),
    );
  }

  Widget _getBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _getStoreTabWidget(),
          _getRecommendedItems(),
          _getBannerWidget(),
        ],
      ),
    );
  }

  Widget _getStoreTabWidget() {
    final tabData = [
      StoreTabData('CU', const Color.fromRGBO(245, 249, 233, 1.0)),
      StoreTabData('GS25', const Color.fromRGBO(230, 247, 250, 1.0)),
      StoreTabData('이마트24', const Color.fromRGBO(255, 245, 228, 1.0)),
      StoreTabData('세븐일레븐', const Color.fromRGBO(229, 240, 230, 1.0)),
      StoreTabData('미니스톱', const Color.fromRGBO(225, 230, 240, 1.0)),
    ];
    return Row(
      children: tabData.map((e) =>
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  Container(
                    color: e.color,
                    height: 80,
                  ),
                  Text(
                    e.name,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          )
      ).toList(),
    );
  }

  Widget _getRecommendedItems() {
    return Column(
      children: const [
        Text('추천 1+1 제품'),
      ],
    );
  }

  Widget _getBannerWidget() {
    return Container(
      height: 100,
      color: const Color.fromRGBO(222, 222, 222, 1.0),
    );
  }
}

class StoreTabData {
  String name;
  Color color;

  StoreTabData(this.name, this.color);
}