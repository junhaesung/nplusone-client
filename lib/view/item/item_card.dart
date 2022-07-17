import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nplusone/adapter/api/dto/item_response.dart';

class ItemCard extends StatelessWidget {
  const ItemCard(
    this.itemResponse, {
    Key? key,
  }) : super(key: key);
  final ItemResponse itemResponse;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.network(
              itemResponse.imageUrl!,
              height: 150,
              errorBuilder: (context, error, stackTrace) {
                if (kDebugMode) {
                  print("error: $error");
                  print("stackTrace: $stackTrace");
                }
                return const SizedBox(
                  height: 150,
                );
              },
            ),
          ),
          Text(itemResponse.storeType),
          Text(itemResponse.name),
          Text("${itemResponse.price}원"),
          Text(itemResponse.discountType),
        ],
      ),
    );
  }
}
