import 'package:nplusone/adapter/api/dto/item_response.dart';
import 'package:nplusone/adapter/api/dto/login_response.dart';
import 'package:nplusone/adapter/api/dto/search_history_response.dart';
import 'package:nplusone/adapter/api/dto/search_word_response.dart';

class ApiResponse<T> {
  String code;
  String message;
  T? data;
  bool? hasNext;
  int? offsetId;

  ApiResponse({
    required this.code,
    required this.message,
    this.data,
    this.hasNext,
    this.offsetId,
  });

  static ApiResponse emptyData(Map<String, dynamic> json) {
    return ApiResponse(
      code: json['code'] as String,
      message: json['message'] as String,
    );
  }

  static ApiResponse<LoginResponse> loginResponse(Map<String, dynamic> json) {
    return ApiResponse(
      code: json['code'] as String,
      message: json['message'] as String,
      data: LoginResponse.fromJson(json['data']),
    );
  }

  static ApiResponse<List<ItemResponse>> itemResponses(
    Map<String, dynamic> json,
  ) {
    return ApiResponse(
      code: json['code'] as String,
      message: json['message'] as String,
      data: json['data'] != null
          ? (json['data'] as List).map((e) => ItemResponse.fromJson(e)).toList()
          : null,
      hasNext: json['hasNext'],
      offsetId: json['offsetId'],
    );
  }

  /// TODO: paging
  static ApiResponse<List<SearchHistoryResponse>> searchHistoryResponse(
    Map<String, dynamic> json,
  ) {
    return ApiResponse(
      code: json['code'] as String,
      message: json['message'] as String,
      data: json['data'] != null
          ? (json['data'] as List)
              .map((e) => SearchHistoryResponse.fromJson(e))
              .toList()
          : null,
    );
  }

  static ApiResponse<List<SearchWordResponse>> searchWordResponse(
    Map<String, dynamic> json,
  ) {
    return ApiResponse(
      code: json['code'] as String,
      message: json['message'] as String,
      data: json['data'] != null
          ? (json['data'] as List)
              .map((e) => SearchWordResponse.fromJson(e))
              .toList()
          : null,
    );
  }

  @override
  String toString() {
    return 'ApiResponse{code: $code, message: $message, data: $data}';
  }
}
