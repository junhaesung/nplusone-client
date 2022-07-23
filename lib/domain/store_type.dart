enum StoreType {
  gs25,
  cu,
  sevenEleven,
  emart24,
  ministop,
  ;

  static StoreType fromQueryName(String value) {
    switch (value) {
      case 'GS25':
        return StoreType.gs25;
      case 'CU':
        return StoreType.cu;
      case 'SEVEN_ELEVEN':
        return StoreType.sevenEleven;
      case 'EMART24':
        return StoreType.emart24;
      case 'MINISTOP':
        return StoreType.ministop;
      default:
        throw Exception('Failed to parse storeType. value:$value');
    }
  }

  String getName() {
    switch(this) {
      case StoreType.gs25:
        return "GS25";
      case StoreType.cu:
        return "CU";
      case StoreType.sevenEleven:
        return "7-ELEVEN";
      case StoreType.emart24:
        return "emart24";
      case StoreType.ministop:
        return "MINISTOP";
    }
  }

  String getQueryName() {
    switch(this) {
      case StoreType.gs25:
        return "GS25";
      case StoreType.cu:
        return "CU";
      case StoreType.sevenEleven:
        return "SEVEN_ELEVEN";
      case StoreType.emart24:
        return "EMART24";
      case StoreType.ministop:
        return "MINISTOP";
    }
  }
}