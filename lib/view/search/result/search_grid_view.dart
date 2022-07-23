import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nplusone/adapter/api/dto/item_response.dart';
import 'package:nplusone/adapter/api/nplusone_api.dart';
import 'package:nplusone/domain/discount_type.dart';
import 'package:nplusone/domain/store_type.dart';
import 'package:nplusone/view/item/item_card.dart';

class SearchGridView extends StatefulWidget {
  const SearchGridView({
    super.key,
    required this.items,
    required this.searchWord,
    this.storeType,
    this.discountType,
  });

  final List<ItemResponse> items;
  final String searchWord;
  final StoreType? storeType;
  final DiscountType? discountType;

  @override
  State<StatefulWidget> createState() => _SearchGridViewState();
}

class _SearchGridViewState extends State<SearchGridView> {
  final _api = const NplusoneApi();
  final _scrollController = ScrollController();
  final List<ItemResponse> itemResponses = [];

  @override
  void initState() {
    super.initState();
    itemResponses.addAll(widget.items);
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (kDebugMode) {
          print('스크롤 끝');
        }
        final apiResponse = await _api.search(
          searchWord: widget.searchWord,
          storeType: widget.storeType,
          discountType: widget.discountType,
          offsetId: itemResponses.isEmpty ? 0 : itemResponses.last.itemDetailId,
          size: 20,
        );
        if (!mounted) {
          return;
        }
        setState(() {
          itemResponses.addAll(apiResponse.data!);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (itemResponses.isEmpty) {
      return const Center(child: Text('조건에 맞는 상품이 없습니다'));
    }
    return GridView.builder(
      controller: _scrollController,
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12.0,
        crossAxisSpacing: 12.0,
        childAspectRatio: 90 / 160,
      ),
      itemCount: itemResponses.length,
      itemBuilder: (context, index) => ItemCard(itemResponses[index]),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
