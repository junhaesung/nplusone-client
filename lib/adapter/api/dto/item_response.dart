class ItemResponse {
  final int itemDetailId;
  final int itemId;
  final String name;
  final String price;
  final String? imageUrl;
  final String discountType;
  final String storeType;
  final String referenceDate;

  const ItemResponse(
    this.itemDetailId,
    this.itemId,
    this.name,
    this.price,
    this.imageUrl,
    this.discountType,
    this.storeType,
    this.referenceDate,
  );

  factory ItemResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      ItemResponse(
        json['itemDetailId'],
        json['itemId'],
        json['name'],
        json['price'].toString(),
        json['imageUrl'],
        json['discountType'],
        json['storeType'],
        json['referenceDate'],
      );

  @override
  String toString() {
    return 'ItemResponse{itemDetailId: $itemDetailId, itemId: $itemId, name: $name, price: $price, imageUrl: $imageUrl, discountType: $discountType, storeType: $storeType, referenceDate: $referenceDate}';
  }
}
