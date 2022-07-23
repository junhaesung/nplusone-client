import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nplusone/view/navigation/tab_page_cubit.dart';
import 'package:nplusone/view/nplusone_colors.dart';

class BottomTabBar extends StatelessWidget {
  const BottomTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabPageCubit, TabPageState>(
      builder: (context, state) {
        return BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book_outlined),
              label: 'Item',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz_outlined),
              label: 'More',
            ),
          ],
          currentIndex: state.index,
          onTap: (int index) {
            if (index == 0) {
              context.read<TabPageCubit>().showHomePage();
            }
            if (index == 1) {
              context.read<TabPageCubit>().showSearchPage();
            }
            if (index == 2) {
              context.read<TabPageCubit>().showItemPage();
            }
            if (index == 3) {
              context.read<TabPageCubit>().showMorePage();
            }
          },
          selectedItemColor: NplusoneColors.purple,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
        );
      },
    );
  }
}
