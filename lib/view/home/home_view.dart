import 'package:flutter/material.dart';
import 'package:nplusone/adapter/api/dto/api_response.dart';
import 'package:nplusone/adapter/api/dto/item_response.dart';
import 'package:nplusone/adapter/api/nplusone_api.dart';
import 'package:nplusone/domain/discount_type.dart';
import 'package:nplusone/domain/store_type.dart';
import 'package:nplusone/view/appbar/nplusone_app_bar.dart';
import 'package:nplusone/view/item/item_card.dart';
import 'package:nplusone/view/navigation/bottom_tab_bar.dart';
import 'package:nplusone/view/recommend/recommend_view.dart';
import 'package:nplusone/view/store/store_label.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  // TODO: DI
  final _api = const NplusoneApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NplusoneAppBar.home(),
      body: _getBody(context),
      bottomNavigationBar: const BottomTabBar(),
    );
  }

  Widget _getBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _getStoreTabWidget(),
          _getRecommendedItems(context),
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

  Widget _getRecommendedItems(BuildContext context) {
    const label = '추천 1+1 제품';
    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                label,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const RecommendView(title: label),
                    ),
                  );
                },
                child: const Text(
                  '전체보기',
                  style: TextStyle(
                    color: Color.fromRGBO(112, 112, 112, 1.0),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 240,
            child: FutureBuilder(
              future: _api.getRecommendedItems(
                discountType: DiscountType.onePlusOne,
              ),
              builder: (
                context,
                AsyncSnapshot<ApiResponse<List<ItemResponse>>> snapshot,
              ) {
                if (!snapshot.hasData) {
                  return Container();
                }
                final itemResponses = snapshot.data!.data!.take(20);
                return ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: itemResponses
                      .map((e) => ItemCard(e, imageHeight: 120))
                      .toList(),
                );
              },
            ),
          ),
        ],
      ),
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
