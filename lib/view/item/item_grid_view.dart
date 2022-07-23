import 'package:flutter/material.dart';
import 'package:nplusone/adapter/api/dto/item_response.dart';
import 'package:nplusone/adapter/api/nplusone_api.dart';
import 'package:nplusone/domain/store_type.dart';
import 'package:nplusone/view/item/item_card.dart';
import 'package:nplusone/view/item/item_store_tab.dart';

class ItemGridView extends StatefulWidget {
  const ItemGridView({
    super.key,
    required this.items,
    required this.storeType,
    required this.stream,
  });

  final List<ItemResponse> items;
  final StoreType? storeType;
  final Stream<ItemStoreTab> stream;

  @override
  State<StatefulWidget> createState() => _ItemGridViewState();
}

class _ItemGridViewState extends State<ItemGridView> {
  final List<ItemResponse> items = [];
  final _api = const NplusoneApi();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    items.addAll(widget.items);
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        final apiResponse = await _api.getItems(
          storeType: widget.storeType,
          offsetId: items.isEmpty ? 0 : items.last.itemDetailId,
          size: 10,
        );
        if (!mounted) {
          return;
        }
        setState(() {
          items.addAll(apiResponse.data!);
        });
      }
    });
    // 탭 변경 이벤트 수신
    widget.stream.listen((number) {
      if (!mounted) {
        return;
      }
      setState(() {
        items.clear();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12.0,
        crossAxisSpacing: 12.0,
        childAspectRatio: 90 / 160,
      ),
      controller: _scrollController,
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return ItemCard(items[index]);
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
