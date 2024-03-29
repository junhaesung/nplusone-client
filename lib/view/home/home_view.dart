import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nplusone/adapter/api/dto/api_response.dart';
import 'package:nplusone/adapter/api/dto/item_response.dart';
import 'package:nplusone/adapter/api/nplusone_api.dart';
import 'package:nplusone/domain/discount_type.dart';
import 'package:nplusone/domain/store_type.dart';
import 'package:nplusone/view/appbar/nplusone_app_bar.dart';
import 'package:nplusone/view/item/item_card.dart';
import 'package:nplusone/view/navigation/bottom_tab_bar.dart';
import 'package:nplusone/view/navigation/tab_page_cubit.dart';
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
          _getStoreTabWidget(context),
          _getRecommendedItems(context),
          _getBannerWidget(),
        ],
      ),
    );
  }

  Widget _getStoreTabWidget(BuildContext context) {
    final tabData = [
      StoreTabData(
        storeType: StoreType.cu,
        title: StoreLabel.of(StoreType.cu),
        image: Image.asset(
          "images/drawable-xhdpi/main_icon_cu.png",
          fit: BoxFit.fitHeight,
        ),
      ),
      StoreTabData(
        storeType: StoreType.gs25,
        title: StoreLabel.of(StoreType.gs25),
        image: Image.asset(
          "images/drawable-xhdpi/main_icon_gs25.png",
          fit: BoxFit.fitHeight,
        ),
      ),
      StoreTabData(
        storeType: StoreType.emart24,
        title: StoreLabel.of(StoreType.emart24),
        image: Image.asset(
          "images/drawable-xhdpi/main_icon_emart24.png",
          fit: BoxFit.fitHeight,
        ),
      ),
      StoreTabData(
        storeType: StoreType.sevenEleven,
        title: StoreLabel.of(StoreType.sevenEleven),
        image: Image.asset(
          "images/drawable-xhdpi/main_icon_seven_eleven.png",
          fit: BoxFit.fitHeight,
        ),
      ),
      StoreTabData(
        storeType: StoreType.ministop,
        title: StoreLabel.of(StoreType.ministop),
        image: Image.asset(
          "images/drawable-xhdpi/main_icon_ministop.png",
          fit: BoxFit.fitHeight,
        ),
      ),
    ];
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 5,
        childAspectRatio: 10 / 13,
        crossAxisSpacing: 7.0,
        shrinkWrap: true,
        children: tabData
            .map((e) => GestureDetector(
                  onTap: () {
                    // move to item view
                    context.read<TabPageCubit>().showItemPage(
                          storeType: e.storeType,
                        );
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: e.image,
                        ),
                      ),
                      const SizedBox(height: 4.0),
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
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
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
                final itemResponses = snapshot.data!.data!.take(20).toList();
                return ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) =>
                      ItemCard(itemResponses[index], imageHeight: 140),
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 10),
                  itemCount: itemResponses.length,
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
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 100,
        color: const Color.fromRGBO(222, 222, 222, 1.0),
      ),
    );
  }
}

class StoreTabData {
  StoreType storeType;
  Widget title;
  Widget image;

  StoreTabData({
    required this.storeType,
    required this.title,
    required this.image,
  });
}
