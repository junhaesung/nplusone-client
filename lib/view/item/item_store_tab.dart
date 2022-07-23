import 'package:nplusone/domain/store_type.dart';

enum ItemStoreTab {
  all,
  cu,
  gs25,
  emart24,
  sevenEleven,
  ministop,
  ;

  factory ItemStoreTab.from(StoreType? storeType) {
    switch (storeType) {
      case StoreType.cu:
        return ItemStoreTab.cu;
      case StoreType.gs25:
        return ItemStoreTab.gs25;
      case StoreType.emart24:
        return ItemStoreTab.emart24;
      case StoreType.sevenEleven:
        return ItemStoreTab.sevenEleven;
      case StoreType.ministop:
        return ItemStoreTab.ministop;
      default:
        return ItemStoreTab.all;
    }
  }

  String getName() {
    switch (this) {
      case all:
        return "전체";
      case cu:
        return "CU";
      case gs25:
        return "GS25";
      case emart24:
        return "이마트24";
      case sevenEleven:
        return "세븐일레븐";
      case ministop:
        return "미니스톱";
      default:
        return "";
    }
  }

  StoreType? toStoreType() {
    switch (this) {
      case all:
        return null;
      case cu:
        return StoreType.cu;
      case gs25:
        return StoreType.gs25;
      case emart24:
        return StoreType.emart24;
      case sevenEleven:
        return StoreType.sevenEleven;
      case ministop:
        return StoreType.ministop;
      default:
        return null;
    }
  }
}
