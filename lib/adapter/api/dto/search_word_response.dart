class SearchWordResponse {
  final String searchWord;

  SearchWordResponse(this.searchWord);

  factory SearchWordResponse.fromJson(Map<String, dynamic> json) =>
      SearchWordResponse(json['searchWord']);

  @override
  String toString() {
    return 'SearchWordResponse{searchWord: $searchWord}';
  }
}
