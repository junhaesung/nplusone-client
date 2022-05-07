import 'package:flutter_bloc/flutter_bloc.dart';

part 'tab_page_state.dart';

class TabPageCubit extends Cubit<TabPageState> {
  TabPageCubit() : super(TabPageState.category);

  showCategoryPage() {
    if (state != TabPageState.category) {
      emit(TabPageState.category);
    }
  }

  showSearchPage() {
    if (state != TabPageState.search) {
      emit(TabPageState.search);
    }
  }

  showSettingPage() {
    if (state != TabPageState.setting) {
      emit(TabPageState.setting);
    }
  }
}
