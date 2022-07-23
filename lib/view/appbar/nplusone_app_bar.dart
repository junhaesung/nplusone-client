import 'package:flutter/material.dart';

class NplusoneAppBar {
  /// 홈 화면
  static PreferredSizeWidget home() {
    return _default();
  }

  /// 검색어 입력
  static PreferredSizeWidget search() {
    return _default();
  }

  /// 검색 결과
  static PreferredSizeWidget searchResult(
    BuildContext context,
  ) {
    return _default(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.of(context).pop();
        },
        color: Colors.black54,
      ),
    );
  }

  /// 상품 목록
  static PreferredSizeWidget item() {
    return _default();
  }

  /// 더 보기
  static PreferredSizeWidget more() {
    return _default();
  }

  /// 추천 상품 목록
  static PreferredSizeWidget recommend(
    BuildContext context, {
    String? title,
  }) {
    return _default(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.of(context).pop();
        },
        color: Colors.black54,
      ),
      title: title,
    );
  }

  static PreferredSizeWidget _default({
    Widget? leading,
    String? title,
  }) {
    return AppBar(
      leading: leading ??
          const Icon(
            Icons.menu,
            color: Colors.black54,
          ),
      title: Text(
        title ?? '불-편',
        style: const TextStyle(
          color: Colors.black,
          fontFamily: 'BmDohyeon',
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.notifications_outlined,
            color: Colors.black54,
          ),
        ),
      ],
      backgroundColor: Colors.transparent,
      // Remove shadow
      elevation: 0,
    );
  }
}
