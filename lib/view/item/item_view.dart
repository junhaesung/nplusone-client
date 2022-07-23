import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nplusone/adapter/api/dto/api_response.dart';
import 'package:nplusone/adapter/api/dto/item_response.dart';
import 'package:nplusone/adapter/api/nplusone_api.dart';
import 'package:nplusone/domain/store_type.dart';
import 'package:nplusone/view/appbar/nplusone_app_bar.dart';
import 'package:nplusone/view/item/item_grid_view.dart';
import 'package:nplusone/view/item/item_store_tab.dart';
import 'package:nplusone/view/navigation/bottom_tab_bar.dart';
import 'package:nplusone/view/nplusone_colors.dart';

class ItemView extends StatefulWidget {
  const ItemView({Key? key, this.storeType}) : super(key: key);

  final StoreType? storeType;

  @override
  State<StatefulWidget> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView>
    with SingleTickerProviderStateMixin {

  // TODO: dependency injection
  final _api = const NplusoneApi();
  late final TabController _tabController =
      TabController(length: 6, vsync: this);
  final StreamController<ItemStoreTab> _streamController =
      StreamController.broadcast();

  late ItemStoreTab itemStoreTab;

  @override
  void initState() {
    super.initState();
    itemStoreTab = ItemStoreTab.from(widget.storeType);
    _tabController.index = itemStoreTab.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NplusoneAppBar.item(),
      body: DefaultTabController(
        length: ItemStoreTab.values.length,
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              isScrollable: true,
              onTap: (value) {
                if (value == itemStoreTab.index) {
                  return;
                }
                setState(() {
                  itemStoreTab = ItemStoreTab.values[value];
                  _streamController.add(itemStoreTab);
                });
              },
              tabs: ItemStoreTab.values
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
              child: _buildWithoutFuture(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomTabBar(),
    );
  }

  Widget _buildWithoutFuture() {
    return FutureBuilder(
        future: _api.getItems(
          storeType: itemStoreTab.toStoreType(),
          size: 10,
        ),
        builder: (
          context,
          AsyncSnapshot<ApiResponse<List<ItemResponse>>> snapshot,
        ) {
          if (snapshot.hasError) {
            return Container();
          }
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }
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
                    FutureBuilder(
                        future: _api.countItems(
                          storeType: itemStoreTab.toStoreType(),
                          size: 1,
                        ),
                        builder: (context,
                            AsyncSnapshot<ApiResponse<int?>> snapshot) {
                          late String totalCount;
                          if (snapshot.connectionState ==
                                  ConnectionState.none ||
                              snapshot.connectionState ==
                                  ConnectionState.waiting ||
                              !snapshot.hasData ||
                              snapshot.hasError) {
                            totalCount = '';
                          } else {
                            totalCount = '${snapshot.data!.data!}';
                          }
                          return Text(
                            totalCount,
                            style: const TextStyle(
                              fontSize: 13,
                              color: NplusoneColors.purple,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }),
                  ],
                ),
                const SizedBox(height: 16.0),
                Expanded(
                  child: ItemGridView(
                    items: snapshot.data!.data!,
                    storeType: itemStoreTab.toStoreType(),
                    stream: _streamController.stream,
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _streamController.close();
    super.dispose();
  }
}
