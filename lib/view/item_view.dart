import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nplusone/adapter/api/dto/api_response.dart';
import 'package:nplusone/adapter/api/dto/item_response.dart';
import 'package:nplusone/adapter/api/nplusone_api.dart';
import 'package:nplusone/domain/store_type.dart';
import 'package:nplusone/view/navigation/bottom_tab_bar.dart';

class ItemView extends StatefulWidget {
  const ItemView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  // TODO: dependency injection
  final api = const NplusoneApi();
  StoreTab storeTab = StoreTab.ALL;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.menu,
          color: Colors.black54,
        ),
        title: const Text('상품'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_outlined,
              color: Colors.black54,
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        // Remove shadow
        elevation: 0,
      ),
      body: DefaultTabController(
        length: 6,
        child: Column(
          children: [
            TabBar(
                isScrollable: true,
                onTap: (value) {
                  setState(() {
                    storeTab = StoreTab.values[value];
                  });
                },
                tabs: StoreTab.values
                    .map((e) => Tab(
                          child: Text(
                            e.getName(),
                            style: const TextStyle(color: Colors.black54),
                          ),
                        ))
                    .toList()),
            Expanded(
              child: FutureBuilder<ApiResponse<List<ItemResponse>>>(
                future: api.getItems(
                  storeType: storeTab.toStoreType(),
                  size: 10000,
                ),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
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
                            crossAxisCount: 2,
                            childAspectRatio: 90 / 120,
                            // crossAxisSpacing: 12,
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            children: itemResponses
                                .map((e) => Card(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Image.network(
                                              e.imageUrl!,
                                              height: 150,
                                              errorBuilder:
                                                  (BuildContext context,
                                                      Object error,
                                                      StackTrace? stackTrace) {
                                                if (kDebugMode) {
                                                  print("error: $error");
                                                  print(
                                                      "stackTrace: $stackTrace");
                                                }
                                                return Container(
                                                  height: 150,
                                                );
                                              },
                                            ),
                                          ),
                                          Text(e.storeType),
                                          Text(e.name),
                                          Text("${e.price}원"),
                                          Text(e.discountType),
                                        ],
                                      ),
                                    ))
                                .toList(),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomTabBar(),
    );
  }
}

enum StoreTab {
  ALL,
  CU,
  GS25,
  EMART24,
  SEVEN_ELEVEN,
  MINISTOP,
  ;

  String getName() {
    switch (this) {
      case ALL:
        return "전체";
      case CU:
        return "CU";
      case GS25:
        return "GS25";
      case EMART24:
        return "이마트24";
      case SEVEN_ELEVEN:
        return "세븐일레븐";
      case MINISTOP:
        return "미니스톱";
      default:
        return "";
    }
  }

  StoreType? toStoreType() {
    switch (this) {
      case ALL:
        return null;
      case CU:
        return StoreType.cu;
      case GS25:
        return StoreType.gs25;
      case EMART24:
        return StoreType.emart24;
      case SEVEN_ELEVEN:
        return StoreType.sevenEleven;
      case MINISTOP:
        return StoreType.ministop;
      default:
        return null;
    }
  }
}
