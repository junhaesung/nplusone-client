import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nplusone/adapter/api/dto/api_response.dart';
import 'package:nplusone/adapter/api/dto/item_response.dart';
import 'package:nplusone/adapter/api/nplusone_api.dart';
import 'package:nplusone/domain/store_type.dart';
import 'package:nplusone/view/appbar/nplusone_app_bar.dart';
import 'package:nplusone/view/item/item_card.dart';
import 'package:nplusone/view/navigation/bottom_tab_bar.dart';
import 'package:nplusone/view/nplusone_colors.dart';

class ItemView extends StatefulWidget {
  const ItemView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  // TODO: dependency injection
  final _api = const NplusoneApi();
  final Map<_StoreTab, int> offsetIdMap = {
    for (final e in _StoreTab.values) e: 0
  };

  _StoreTab storeTab = _StoreTab.all;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    storeTab = _StoreTab.all;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NplusoneAppBar.item(),
      body: DefaultTabController(
        length: _StoreTab.values.length,
        child: Column(
          children: [
            TabBar(
              isScrollable: true,
              onTap: (value) {
                setState(() {
                  storeTab = _StoreTab.values[value];
                  _scrollController.jumpTo(_scrollController.position.minScrollExtent);
                });
              },
              tabs: _StoreTab.values
                  .map((e) => Tab(child: Text(e.getName())))
                  .toList(),
              indicatorColor: NplusoneColors.purple,
              indicatorWeight: 3.0,
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: NplusoneColors.purple,
              labelStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelColor: Colors.black54,
              unselectedLabelStyle: const TextStyle(
                fontSize: 15,
              ),
            ),
            Expanded(
              child: _buildWithFutureBuilder(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomTabBar(),
    );
  }

  // TODO: paging
  FutureBuilder<ApiResponse<List<ItemResponse>>> _buildWithFutureBuilder() {
    return FutureBuilder<ApiResponse<List<ItemResponse>>>(
      future: _api.getItems(
        storeType: storeTab.toStoreType(),
        size: 10000,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none ||
            snapshot.connectionState == ConnectionState.waiting ||
            !snapshot.hasData) {
          return Container();
        }
        final itemResponses = snapshot.data!.data!;
        final totalCount = itemResponses.length;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("전체: $totalCount"),
              Expanded(
                child: GridView.count(
                  controller: _scrollController,
                  crossAxisCount: 2,
                  childAspectRatio: 90 / 150,
                  // crossAxisSpacing: 12,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  children: itemResponses.map((e) => ItemCard(e)).toList(),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

enum _StoreTab {
  all,
  cu,
  gs25,
  emart24,
  sevenEleven,
  ministop,
  ;

  String getName() {
    switch (this) {
      case all:
        return "전체";
      case cu:
        return "CU";
      case gs25:
        return "GS25";
      case emart24:
        return "이마트24";
      case sevenEleven:
        return "세븐일레븐";
      case ministop:
        return "미니스톱";
      default:
        return "";
    }
  }

  StoreType? toStoreType() {
    switch (this) {
      case all:
        return null;
      case cu:
        return StoreType.cu;
      case gs25:
        return StoreType.gs25;
      case emart24:
        return StoreType.emart24;
      case sevenEleven:
        return StoreType.sevenEleven;
      case ministop:
        return StoreType.ministop;
      default:
        return null;
    }
  }
}
