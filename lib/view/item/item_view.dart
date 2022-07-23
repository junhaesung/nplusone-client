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
  const ItemView({Key? key, this.storeType}) : super(key: key);

  final StoreType? storeType;

  @override
  State<StatefulWidget> createState() => _ItemViewState(storeType);
}

class _ItemViewState extends State<ItemView> with SingleTickerProviderStateMixin {
  _ItemViewState(this.storeType);

  // TODO: dependency injection
  final _api = const NplusoneApi();
  final Map<_StoreTab, int> offsetIdMap = {
    for (final e in _StoreTab.values) e: 0
  };
  final ScrollController _scrollController = ScrollController();
  late final TabController _tabController = TabController(length: 6, vsync: this);

  StoreType? storeType;
  late _StoreTab storeTab;

  @override
  void initState() {
    super.initState();
    storeTab = _StoreTab.from(storeType);
    _tabController.index = storeTab.index;
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
              controller: _tabController,
              isScrollable: true,
              onTap: (value) {
                setState(() {
                  storeTab = _StoreTab.values[value];
                  _scrollController
                      .jumpTo(_scrollController.position.minScrollExtent);
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    '전체',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    '$totalCount',
                    style: const TextStyle(
                      fontSize: 13,
                      color: NplusoneColors.purple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: GridView.count(
                  controller: _scrollController,
                  crossAxisCount: 2,
                  childAspectRatio: 90 / 160,
                  mainAxisSpacing: 12.0,
                  crossAxisSpacing: 12.0,
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

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
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

  factory _StoreTab.from(StoreType? storeType) {
    switch(storeType) {
      case StoreType.cu:
        return _StoreTab.cu;
      case StoreType.gs25:
        return _StoreTab.gs25;
      case StoreType.emart24:
        return _StoreTab.emart24;
      case StoreType.sevenEleven:
        return _StoreTab.sevenEleven;
      case StoreType.ministop:
        return _StoreTab.ministop;
      default:
        return _StoreTab.all;
    }
  }

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
