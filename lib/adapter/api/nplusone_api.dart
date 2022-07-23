import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nplusone/adapter/api/dto/api_response.dart';
import 'package:nplusone/adapter/api/dto/item_response.dart';
import 'package:nplusone/adapter/api/dto/login_response.dart';
import 'package:nplusone/adapter/api/dto/search_history_response.dart';
import 'package:nplusone/adapter/api/dto/search_word_response.dart';
import 'package:nplusone/adapter/storage/token_storage_api.dart';
import 'package:nplusone/domain/discount_type.dart';
import 'package:nplusone/domain/store_type.dart';

class NplusoneApi {
  const NplusoneApi();

  final String _host = "nplusone.hae-seong.com";
  final TokenStorageApi _tokenStorageApi = const TokenStorageApi();

  /// login
  Future<ApiResponse<LoginResponse>> login({
    required String firebaseUserId,
  }) async {
    return http
        .post(
          Uri.http(_host, '/api/v1/members/login'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'idProviderType': 'FIREBASE',
            'idProviderUserId': firebaseUserId,
          }),
        )
        .then((value) => json.decode(utf8.decode(value.bodyBytes)))
        .then((value) => ApiResponse.loginResponse(value));
  }

  /// item 목록 조회
  Future<ApiResponse<List<ItemResponse>>> getItems({
    String? name,
    StoreType? storeType,
    int offsetId = 0,
    int size = 20,
  }) async {
    final accessToken = await _tokenStorageApi.read();
    final queryParameterMap = <String, dynamic>{};
    if (name != null && name.isNotEmpty) {
      queryParameterMap['name'] = name;
    }
    if (storeType != null) {
      queryParameterMap['storeType'] = storeType.getQueryName();
    }
    queryParameterMap['offsetId'] = offsetId.toString();
    queryParameterMap['pageSize'] = size.toString();
    return http
        .get(
          Uri.http(_host, '/api/v1/items', queryParameterMap),
          headers: {'Authorization': 'Bearer $accessToken'},
        )
        .then((value) => json.decode(utf8.decode(value.bodyBytes)))
        .then((value) => ApiResponse.itemResponses(value));
  }

  /// 검색
  Future<ApiResponse<List<ItemResponse>>> search({
    String? searchWord,
    StoreType? storeType,
    int offsetId = 0,
    int size = 20,
  }) async {
    final accessToken = await _tokenStorageApi.read();
    return http
        .post(Uri.http(_host, '/api/v1/search'),
            headers: {
              'Authorization': 'Bearer $accessToken',
              'Content-Type': 'application/json',
            },
            body: json.encode({
              'searchWord': searchWord,
              'storeType': storeType?.getName(),
              'offsetId': offsetId,
              'pageSize': size,
            }))
        .then((value) => json.decode(utf8.decode(value.bodyBytes)))
        .then((value) => ApiResponse.itemResponses(value));
  }

  /// 최근 검색어 목록
  Future<ApiResponse<List<SearchHistoryResponse>>> getSearchHistories() async {
    final accessToken = await _tokenStorageApi.read();
    return http
        .get(
          Uri.http(_host, '/api/v1/search-histories'),
          headers: {'Authorization': 'Bearer $accessToken'},
        )
        .then((value) => json.decode(utf8.decode(value.bodyBytes)))
        .then((value) => ApiResponse.searchHistoryResponse(value));
  }

  /// 최근 검색어 삭제
  Future<ApiResponse> deleteSearchHistory({
    required int searchHistoryId,
  }) async {
    final accessToken = await _tokenStorageApi.read();
    return http
        .delete(
          Uri.http(_host, '/api/v1/search-histories/$searchHistoryId'),
          headers: {'Authorization': 'Bearer $accessToken'},
        )
        .then((value) => json.decode(utf8.decode(value.bodyBytes)))
        .then((value) => ApiResponse.emptyData(value));
  }

  /// 인기 검색어 목록
  Future<ApiResponse<List<SearchWordResponse>>> getSearchWords() async {
    final accessToken = await _tokenStorageApi.read();
    return http
        .get(
          Uri.http(_host, '/api/v1/search-words'),
          headers: {'Authorization': 'Bearer $accessToken'},
        )
        .then((value) => json.decode(utf8.decode(value.bodyBytes)))
        .then((value) => ApiResponse.searchWordResponse(value));
  }

  /// 추천
  Future<ApiResponse<List<ItemResponse>>> getRecommendedItems({
    StoreType? storeType,
    DiscountType? discountType,
  }) async {
    final accessToken = await _tokenStorageApi.read();
    return http
        .post(
          Uri.http(_host, '/api/v1/recommend'),
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'storeType': storeType?.getQueryName(),
            'discountType': discountType?.getQueryName(),
          }),
        )
        .then((value) => json.decode(utf8.decode(value.bodyBytes)))
        .then((value) => ApiResponse.itemResponses(value));
  }
}
