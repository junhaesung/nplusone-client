import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nplusone/adapter/api/dto/api_response.dart';
import 'package:nplusone/adapter/api/dto/item_response.dart';

class NplusoneApi {
  const NplusoneApi();

  final String _host = "nplusone.hae-seong.com";

  Future<ApiResponse<List<ItemResponse>>> getItems() {
    return http.get(
      Uri.http(_host, '/api/v1/items'),
    )
        .then((value) => json.decode(utf8.decode(value.bodyBytes)))
        .then((value) => ApiResponse.itemResponses(value));
  }
}
