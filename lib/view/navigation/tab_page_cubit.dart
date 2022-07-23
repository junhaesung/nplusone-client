import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nplusone/domain/store_type.dart';

part 'tab_page_state.dart';

class TabPageCubit extends Cubit<TabPageState> {
  TabPageCubit() : super(TabPageState.home);

  showHomePage() {
    if (state != TabPageState.home) {
      FirebaseAnalytics.instance.setCurrentScreen(screenName: 'Home');
      emit(TabPageState.home);
    }
  }

  showSearchPage() {
    if (state != TabPageState.search) {
      FirebaseAnalytics.instance.setCurrentScreen(screenName: 'Search');
      emit(TabPageState.search);
    }
  }

  showItemPage({
    StoreType? storeType,
  }) {
    if (!state.isItem()) {
      FirebaseAnalytics.instance.setCurrentScreen(screenName: 'Item');
      switch (storeType) {
        case StoreType.cu:
          emit(TabPageState.itemCu);
          break;
        case StoreType.gs25:
          emit(TabPageState.itemGs25);
          break;
        case StoreType.emart24:
          emit(TabPageState.itemEmart24);
          break;
        case StoreType.sevenEleven:
          emit(TabPageState.itemSevenEleven);
          break;
        case StoreType.ministop:
          emit(TabPageState.itemMinistop);
          break;
        default:
          emit(TabPageState.itemAll);
          break;
      }
    }
  }

  showMorePage() {
    if (state != TabPageState.more) {
      FirebaseAnalytics.instance.setCurrentScreen(screenName: 'More');
      emit(TabPageState.more);
    }
  }
}
