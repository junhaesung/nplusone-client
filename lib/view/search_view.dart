import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nplusone/adapter/api/dto/api_response.dart';
import 'package:nplusone/adapter/api/dto/search_history_response.dart';
import 'package:nplusone/adapter/api/dto/search_word_response.dart';
import 'package:nplusone/adapter/api/nplusone_api.dart';
import 'package:nplusone/view/navigation/bottom_tab_bar.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SearchViewState();
  }
}

class SearchViewState extends State<SearchView> {
  // TODO: dependency injection
  final api = const NplusoneApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.menu,
          color: Colors.black54,
        ),
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
      body: FutureBuilder(
        future: Future.wait([
          api.getSearchHistories(),
          api.getSearchWords(),
        ]),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            // loading
            return getSearchTextField();
          }
          final widgets = [
            getSearchTextField(),
            getRecentSearchWords((snapshot.requireData as List)[0]),
            getPopularSearchWords((snapshot.requireData as List)[1]),
          ];
          return ListView.builder(
            itemCount: widgets.length,
            itemBuilder: (context, index) {
              return widgets[index];
            },
          );
        },
      ),
      bottomNavigationBar: const BottomTabBar(),
    );
  }

  /// 검색
  /// TODO: 둥글게 만들기, 검색아이콘
  Widget getSearchTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        onFieldSubmitted: (value) async {
          final searchWord = value.trim();
          if (kDebugMode) {
            print('onFieldSubmitted: $searchWord');
          }
          // api call
          final apiResponse = await api
              .search(searchWord: searchWord)
              .whenComplete(() => setState(() {}));
          if (kDebugMode) {
            print('search: $apiResponse');
          }
        },
        enableSuggestions: false,
        decoration: const InputDecoration(hintText: '원하는 상품을 검색해보세요!'),
        autocorrect: false,
      ),
    );
  }

  /// 최근 검색어
  Widget getRecentSearchWords(
    ApiResponse<List<SearchHistoryResponse>> apiResponse,
  ) {
    if (kDebugMode) {
      print('getRecentSearchWords: $apiResponse');
    }
    final searchWords = apiResponse.data!;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '최근 검색어',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          // api call, results
          Wrap(
            direction: Axis.horizontal,
            spacing: 4.0,
            runSpacing: -4.0,
            children: searchWords.map((e) => _toSearchHistoryChip(e)).toList(),
          ),
        ],
      ),
    );
  }

  /// chip (material design)
  Widget _toSearchHistoryChip(
    SearchHistoryResponse searchHistoryResponse,
  ) {
    return Chip(
      label: Text(searchHistoryResponse.searchWord),
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: Colors.black12),
        borderRadius: BorderRadiusDirectional.all(Radius.circular(20.0)),
      ),
      backgroundColor: Colors.transparent,
      deleteIcon: const Icon(Icons.cancel),
      deleteIconColor: Colors.black26,
      onDeleted: () {
        if (kDebugMode) {
          print("chip on deleted. response: $searchHistoryResponse");
        }
        api
            .deleteSearchHistory(
                searchHistoryId: searchHistoryResponse.searchHistoryId)
            .whenComplete(() => setState(() {}));
        // TODO: refresh 또는 성공확인하고 client 화면에서 삭제,
        // TODO: 실패시 alert. async 인데 api 응답까지 어떻게기다려야할까.
      },
    );
  }

  /// 인기 검색어
  Widget getPopularSearchWords(
    ApiResponse<List<SearchWordResponse>> apiResponse,
  ) {
    if (kDebugMode) {
      print('getPopularSearchWords: $apiResponse');
    }
    final searchWords = apiResponse.data!;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '인기 검색어',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          ListView.separated(
            separatorBuilder: (BuildContext context, int index) => const Divider(),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: searchWords.length,
            itemBuilder: (context, index) {
              final orderNumber = index + 1;
              return ListTile(
                visualDensity: const VisualDensity(vertical: -4.0),
                leading: Text(
                  (orderNumber < 10) ? " $orderNumber" : orderNumber.toString(),
                  textAlign: TextAlign.center,
                ),
                minLeadingWidth: 20.0,
                title: Text(searchWords[index].searchWord),
              );
            },
          ),
        ],
      ),
    );
  }
}
