import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nplusone/view/navigation/tab_page_cubit.dart';

class BottomTabBar extends StatelessWidget {
  const BottomTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabPageCubit, TabPageState>(
      builder: (context, state) {
        return BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Category',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Setting',
            ),
          ],
          currentIndex: state.index,
          selectedItemColor: Colors.blue,
          onTap: (int index) {
            if (index == 0) {
              context.read<TabPageCubit>().showCategoryPage();
            }
            if (index == 1) {
              context.read<TabPageCubit>().showSearchPage();
            }
            if (index == 2) {
              context.read<TabPageCubit>().showSettingPage();
            }
          },
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
        );
      },
    );
  }
}
