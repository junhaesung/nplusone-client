import 'package:flutter/material.dart';
import 'package:nplusone/domain/store_type.dart';
import 'package:nplusone/view/item_list_view.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: StoreType.values.length,
      itemBuilder: (BuildContext context, int index) {
        final storeType = StoreType.values[index];
        return ListTile(
          title: Text(storeType.getName()),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ItemListView(
                storeType: storeType,
              )),
            );
          },
        );
      },
    );
  }
}