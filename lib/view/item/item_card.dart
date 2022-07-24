import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nplusone/adapter/api/dto/item_response.dart';
import 'package:nplusone/domain/discount_type.dart';
import 'package:nplusone/domain/store_type.dart';
import 'package:nplusone/view/nplusone_formatter.dart';
import 'package:nplusone/view/store/store_label.dart';

class ItemCard extends StatelessWidget {
  const ItemCard(
    this.itemResponse, {
    this.imageHeight = 200,
    Key? key,
  }) : super(key: key);
  final ItemResponse itemResponse;
  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    final price = NplusoneFormatter.formatCurrency(
        double.parse(itemResponse.price).toInt());
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                width: 0.5,
                color: const Color.fromRGBO(244, 244, 244, 1.0),
                style: BorderStyle.solid,
              ),
            ),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  itemResponse.imageUrl!,
                  height: imageHeight,
                  errorBuilder: (context, error, stackTrace) {
                    if (kDebugMode) {
                      print("error: $error");
                      print("stackTrace: $stackTrace");
                    }
                    return SizedBox(
                      height: imageHeight,
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          StoreLabel.of(
            StoreType.fromQueryName(itemResponse.storeType),
            fontSize: 11,
          ),
          const SizedBox(height: 6),
          Text(
            itemResponse.name,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.normal,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          Text(
            '$price원',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          _toDiscountTag(DiscountType.fromQueryName(itemResponse.discountType)),
        ],
      ),
    );
  }

  Widget _toDiscountTag(DiscountType discountType) {
    final String labelText;
    switch (discountType) {
      case DiscountType.onePlusOne:
        labelText = '1+1';
        break;
      case DiscountType.twoPlusOne:
        labelText = '2+1';
        break;
    }
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color.fromRGBO(245, 242, 255, 1.0)),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          labelText,
          style: const TextStyle(
            color: Color.fromRGBO(69, 0, 254, 1.0),
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
