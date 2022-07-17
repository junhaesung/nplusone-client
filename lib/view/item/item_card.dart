import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nplusone/adapter/api/dto/item_response.dart';
import 'package:nplusone/domain/store_type.dart';
import 'package:nplusone/view/nplusone_formatter.dart';
import 'package:nplusone/view/store/store_label.dart';

class ItemCard extends StatelessWidget {
  const ItemCard(
    this.itemResponse, {
    Key? key,
  }) : super(key: key);
  final ItemResponse itemResponse;

  @override
  Widget build(BuildContext context) {
    final price = NplusoneFormatter.formatCurrency(
        double.parse(itemResponse.price).toInt());
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
          StoreLabel.of(StoreType.fromQueryName(itemResponse.storeType)),
          Text(itemResponse.name),
          Text('$price원'),
          Text(itemResponse.discountType),
        ],
      ),
    );
  }
}
