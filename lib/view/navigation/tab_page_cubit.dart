import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  showItemPage() {
    if (state != TabPageState.item) {
      FirebaseAnalytics.instance.setCurrentScreen(screenName: 'Item');
      emit(TabPageState.item);
    }
  }

  showMorePage() {
    if (state != TabPageState.more) {
      FirebaseAnalytics.instance.setCurrentScreen(screenName: 'More');
      emit(TabPageState.more);
    }
  }
}
