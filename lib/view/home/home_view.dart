import 'package:flutter/material.dart';
import 'package:nplusone/domain/store_type.dart';
import 'package:nplusone/view/appbar/nplusone_app_bar.dart';
import 'package:nplusone/view/navigation/bottom_tab_bar.dart';
import 'package:nplusone/view/store/store_label.dart';

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
      StoreTabData(
        title: StoreLabel.of(StoreType.cu),
        color: const Color.fromRGBO(245, 249, 233, 1.0),
      ),
      StoreTabData(
        title: StoreLabel.of(StoreType.gs25),
        color: const Color.fromRGBO(230, 247, 250, 1.0),
      ),
      StoreTabData(
        title: StoreLabel.of(StoreType.emart24),
        color: const Color.fromRGBO(255, 245, 228, 1.0),
      ),
      StoreTabData(
        title: StoreLabel.of(StoreType.sevenEleven),
        color: const Color.fromRGBO(229, 240, 230, 1.0),
      ),
      StoreTabData(
        title: StoreLabel.of(StoreType.ministop),
        color: const Color.fromRGBO(225, 230, 240, 1.0),
      ),
    ];
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GridView.count(
        crossAxisCount: 5,
        childAspectRatio: 10 / 12,
        shrinkWrap: true,
        children: tabData
            .map((e) => Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Container(
                            color: e.color,
                          ),
                        ),
                      ),
                      e.title,
                    ],
                  ),
                ))
            .toList(),
      ),
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        color: const Color.fromRGBO(222, 222, 222, 1.0),
      ),
    );
  }
}

class StoreTabData {
  Widget title;
  Color color;

  StoreTabData({required this.title, required this.color});
}
