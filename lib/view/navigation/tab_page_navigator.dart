import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nplusone/view/category_view.dart';
import 'package:nplusone/view/navigation/tab_page_cubit.dart';
import 'package:nplusone/view/search_view.dart';
import 'package:nplusone/view/setting_view.dart';

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
      if (state == TabPageState.category)
        const MaterialPage(child: CategoryView()),
      if (state == TabPageState.search) const MaterialPage(child: SearchView()),
      if (state == TabPageState.setting)
        const MaterialPage(child: SettingView()),
    ];
  }
}
