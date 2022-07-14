import 'package:flutter_bloc/flutter_bloc.dart';

part 'tab_page_state.dart';

class TabPageCubit extends Cubit<TabPageState> {
  TabPageCubit() : super(TabPageState.home);

  showCategoryPage() {
    if (state != TabPageState.home) {
      emit(TabPageState.home);
    }
  }

  showSearchPage() {
    if (state != TabPageState.search) {
      emit(TabPageState.search);
    }
  }

  showItemPage() {
    if (state != TabPageState.item) {
      emit(TabPageState.item);
    }
  }

  showMorePage() {
    if (state != TabPageState.more) {
      emit(TabPageState.more);
    }
  }
}
