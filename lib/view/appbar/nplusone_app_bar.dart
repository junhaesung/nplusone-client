import 'package:flutter/material.dart';

class NplusoneAppBar {
  static PreferredSizeWidget home() {
    return _default();
  }

  static PreferredSizeWidget search() {
    return _default();
  }

  static PreferredSizeWidget item() {
    return _default();
  }

  static PreferredSizeWidget more() {
    return _default();
  }

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
        style: const TextStyle(color: Colors.black54),
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
