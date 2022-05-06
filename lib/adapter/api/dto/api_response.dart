import 'package:nplusone/adapter/api/dto/item_response.dart';

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

  @override
  String toString() {
    return 'ApiResponse{code: $code, message: $message, data: $data}';
  }
}