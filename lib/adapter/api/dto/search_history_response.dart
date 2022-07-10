class SearchHistoryResponse {
  final int searchHistoryId;
  final String searchWord;

  SearchHistoryResponse(this.searchHistoryId, this.searchWord);

  factory SearchHistoryResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      SearchHistoryResponse(
        json['searchHistoryId'],
        json['searchWord'],
      );

  @override
  String toString() {
    return 'SearchHistoryResponse{searchHistoryId: $searchHistoryId, searchWord: $searchWord}';
  }
}
