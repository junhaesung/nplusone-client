enum DiscountType {
  onePlusOne,
  twoPlusOne,
  ;

  static DiscountType fromQueryName(String value) {
    switch (value) {
      case 'ONE_PLUS_ONE':
        return DiscountType.onePlusOne;
      case 'TWO_PLUS_ONE':
        return DiscountType.twoPlusOne;
      default:
        throw Exception('Failed to parse discountType. value: $value');
    }
  }

  String getQueryName() {
    switch (this) {
      case DiscountType.onePlusOne:
        return 'ONE_PLUS_ONE';
      case DiscountType.twoPlusOne:
        return 'TWO_PLUS_ONE';
    }
  }
}
