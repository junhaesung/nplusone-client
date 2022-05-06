import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nplusone/adapter/api/dto/item_response.dart';
import 'package:nplusone/adapter/api/nplusone_api.dart';
import 'package:nplusone/domain/store_type.dart';

class ItemListView extends StatefulWidget {
  const ItemListView({Key? key, required this.storeType}) : super(key: key);
  final StoreType storeType;

  @override
  State<StatefulWidget> createState() {
    return _ItemListViewState(storeType);
  }
}

class _ItemListViewState extends State<ItemListView> {
  _ItemListViewState(this.storeType);

  static const _pageSize = 20;

  final PagingController<int, ItemResponse> _pagingController =
      PagingController(firstPageKey: 0);
  final nplusoneApi = const NplusoneApi();
  final StoreType storeType;

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(offsetId: pageKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Don't worry about displaying progress or error indicators on screen; the
    // package takes care of that. If you want to customize them, use the
    // [PagedChildBuilderDelegate] properties.
    return Scaffold(
      appBar: AppBar(title: Text(storeType.getName())),
      body: PagedListView<int, ItemResponse>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<ItemResponse>(
          itemBuilder: (context, item, index) => ListTile(
            title: Text(item.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.price),
                Text(item.storeType),
                Text(item.discountType),
                Text(item.referenceDate),
              ],
            ),
            trailing: item.imageUrl != null ? Image.network(
              item.imageUrl!,
              errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                return const Text('not found');
              },
            ) : null,
          ),
        ),
      ),
    );
  }

  Future<void> _fetchPage({
    int offsetId = 0
  }) async {
    try {
      final apiResponse = await nplusoneApi.getItems(
        offsetId: offsetId,
        size: _pageSize,
        storeType: storeType,
      );
      final isLastPage = apiResponse.hasNext == false;
      if (isLastPage) {
        _pagingController.appendLastPage(apiResponse.data!);
      } else {
        final nextPageKey = apiResponse.offsetId!;
        _pagingController.appendPage(apiResponse.data!, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }
}
