import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nplusone/domain/store_type.dart';
import 'package:nplusone/view/home/home_view.dart';
import 'package:nplusone/view/item/item_view.dart';
import 'package:nplusone/view/more/more_view.dart';
import 'package:nplusone/view/navigation/tab_page_cubit.dart';
import 'package:nplusone/view/search/search_view.dart';

class TabPageNavigator extends StatelessWidget {
  const TabPageNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabPageCubit, TabPageState>(
      builder: (context, state) => Navigator(
        pages: _getPages(state),
        onPopPage: (route, result) => route.didPop(result),
      ),
    );
  }

  List<Page<dynamic>> _getPages(TabPageState state) {
    return [
      if (state == TabPageState.home) const MaterialPage(child: HomeView()),
      if (state == TabPageState.search) const MaterialPage(child: SearchView()),
      if (state == TabPageState.itemAll) const MaterialPage(child: ItemView()),
      if (state == TabPageState.itemCu)
        const MaterialPage(child: ItemView(storeType: StoreType.cu)),
      if (state == TabPageState.itemGs25)
        const MaterialPage(child: ItemView(storeType: StoreType.gs25)),
      if (state == TabPageState.itemEmart24)
        const MaterialPage(child: ItemView(storeType: StoreType.emart24)),
      if (state == TabPageState.itemSevenEleven)
        const MaterialPage(child: ItemView(storeType: StoreType.sevenEleven)),
      if (state == TabPageState.itemMinistop)
        const MaterialPage(child: ItemView(storeType: StoreType.ministop)),
      if (state == TabPageState.more) const MaterialPage(child: MoreView()),
    ];
  }
}
