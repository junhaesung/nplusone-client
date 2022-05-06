import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nplusone/adapter/api/dto/api_response.dart';
import 'package:nplusone/adapter/api/dto/item_response.dart';
import 'package:nplusone/domain/store_type.dart';

class NplusoneApi {
  const NplusoneApi();

  final String _host = "nplusone.hae-seong.com";

  Future<ApiResponse<List<ItemResponse>>> getItems({
    int offsetId = 0,
    int size = 20,
    StoreType? storeType,
  }) {
    final queryParameterMap = <String, dynamic>{};
    queryParameterMap['offsetId'] = offsetId.toString();
    queryParameterMap['size'] = size.toString();
    if (storeType != null) {
      queryParameterMap['storeType'] = storeType.getQueryName();
    }
    return http
        .get(Uri.http(_host, '/api/v1/items', queryParameterMap))
        .then((value) => json.decode(utf8.decode(value.bodyBytes)))
        .then((value) => ApiResponse.itemResponses(value));
  }
}
