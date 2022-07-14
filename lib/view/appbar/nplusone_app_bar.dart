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

  static PreferredSizeWidget _default() {
    return AppBar(
      leading: const Icon(
        Icons.menu,
        color: Colors.black54,
      ),
      title: const Text(
        '불-편',
        style: TextStyle(color: Colors.black54),
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
