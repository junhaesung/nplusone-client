part of 'tab_page_cubit.dart';

enum TabPageState {
  home(tabIndex: 0),
  search(tabIndex: 1),
  itemAll(tabIndex: 2),
  itemCu(tabIndex: 2),
  itemGs25(tabIndex: 2),
  itemEmart24(tabIndex: 2),
  itemSevenEleven(tabIndex: 2),
  itemMinistop(tabIndex: 2),
  more(tabIndex: 3),
  ;

  final int tabIndex;

  const TabPageState({
    required this.tabIndex
  });

  bool isItem() {
    return this == itemAll
        || this == itemCu
        || this == itemGs25
        || this == itemEmart24
        || this == itemSevenEleven
        || this == itemMinistop;
  }
}
