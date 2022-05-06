enum StoreType {
  gs25,
  cu,
  sevenEleven,
  emart24,
  ministop,
  ;

  String getName() {
    switch(this) {
      case StoreType.gs25:
        return "GS25";
      case StoreType.cu:
        return "CU";
      case StoreType.sevenEleven:
        return "7ELEVEN";
      case StoreType.emart24:
        return "Emart24";
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