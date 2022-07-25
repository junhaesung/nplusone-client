import 'package:flutter/material.dart';
import 'package:nplusone/adapter/api/dto/api_response.dart';
import 'package:nplusone/adapter/api/dto/item_response.dart';
import 'package:nplusone/adapter/api/nplusone_api.dart';
import 'package:nplusone/domain/discount_type.dart';
import 'package:nplusone/domain/store_type.dart';
import 'package:nplusone/view/appbar/nplusone_app_bar.dart';
import 'package:nplusone/view/nplusone_formatter.dart';
import 'package:nplusone/view/search/result/search_grid_view.dart';

class SearchResultView extends StatelessWidget {
  const SearchResultView({
    Key? key,
    this.storeType,
    this.discountType,
    required this.searchWord,
  }) : super(key: key);

  // TODO: dependency injection
  final _api = const NplusoneApi();
  final StoreType? storeType;
  final DiscountType? discountType;
  final String searchWord;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NplusoneAppBar.searchResult(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<ApiResponse<List<ItemResponse>>>(
          future: _api.search(
            searchWord: searchWord,
            storeType: storeType,
            discountType: discountType,
          ),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasError) {
              return Container();
            }
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Container();
              case ConnectionState.active:
              case ConnectionState.done:
                if (!snapshot.hasData) {
                  return const Center(child: Text('조건에 맞는 상품이 없습니다'));
                } else {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Text('\'$searchWord\' 검색결과',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 4),
                          FutureBuilder<ApiResponse<int?>>(
                            future: _api.searchCount(
                              searchWord: searchWord,
                              storeType: storeType,
                              discountType: discountType,
                            ),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Container();
                              }
                              final count = snapshot.data!.data!;
                              return Text(NplusoneFormatter.formatCurrency(count),
                                style: const TextStyle(
                                  color: Color.fromRGBO(69, 0, 255, 1.0),
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: SearchGridView(
                          items: snapshot.data!.data!,
                          storeType: storeType,
                          discountType: discountType,
                          searchWord: searchWord,
                        ),
                      ),
                    ],
                  );
                }
            }
          },
        ),
      ),
    );
  }
}
