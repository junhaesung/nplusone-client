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
              icon: ImageIcon(
                AssetImage('images/drawable-xhdpi/main_tab_home.png'),
              ),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('images/drawable-xhdpi/main_tab_search.png'),
              ),
              label: '검색',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('images/drawable-xhdpi/main_tab_item.png'),
              ),
              label: '상품',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('images/drawable-xhdpi/main_tab_more.png'),
              ),
              label: '더보기',
            ),
          ],
          currentIndex: state.tabIndex,
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
          selectedItemColor: Colors.black,
          unselectedItemColor: const Color.fromRGBO(170, 170, 170, 1.0),
        );
      },
    );
  }
}
