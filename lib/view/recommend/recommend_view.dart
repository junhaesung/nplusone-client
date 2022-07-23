import 'package:flutter/material.dart';
import 'package:nplusone/adapter/api/dto/api_response.dart';
import 'package:nplusone/adapter/api/dto/item_response.dart';
import 'package:nplusone/adapter/api/nplusone_api.dart';
import 'package:nplusone/domain/discount_type.dart';
import 'package:nplusone/view/appbar/nplusone_app_bar.dart';
import 'package:nplusone/view/item/item_card.dart';

class RecommendView extends StatelessWidget {
  const RecommendView({
    super.key,
    required this.title,
  });

  // TODO: dependency injection
  final _api = const NplusoneApi();
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NplusoneAppBar.recommend(
        context,
        title: title,
      ),
      body: FutureBuilder(
        future: _api.getRecommendedItems(
          discountType: DiscountType.onePlusOne,
        ),
        builder:
            (context, AsyncSnapshot<ApiResponse<List<ItemResponse>>> snapshot) {
          if (!snapshot.hasData) {
            // TODO: loading progress
            return Container();
          }
          return GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 90 / 130,
            // crossAxisSpacing: 12,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            children: snapshot.data!.data!
                .map((e) => ItemCard(e, imageHeight: 180))
                .toList(),
          );
        },
      ),
    );
  }
}
