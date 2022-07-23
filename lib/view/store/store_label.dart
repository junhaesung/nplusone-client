import 'package:flutter/material.dart';
import 'package:nplusone/domain/store_type.dart';

class StoreLabel {
  static const double defaultFontSize = 11;

  static Widget of(
    StoreType storeType, {
    double fontSize = defaultFontSize,
  }) {
    switch (storeType) {
      case StoreType.gs25:
        return _gs25(fontSize: fontSize);
      case StoreType.cu:
        return _cu(fontSize: fontSize);
      case StoreType.sevenEleven:
        return _sevenEleven(fontSize: fontSize);
      case StoreType.emart24:
        return _emart24(fontSize: fontSize);
      case StoreType.ministop:
        return _ministop(fontSize: fontSize);
    }
  }

  static Widget _gs25({required double fontSize}) {
    return Text.rich(TextSpan(
      style: TextStyle(
        fontSize: fontSize,
      ),
      children: const [
        TextSpan(
          text: 'GS',
          style: TextStyle(
            color: Color.fromRGBO(14, 99, 175, 1.0),
            fontWeight: FontWeight.w600,
          ),
        ),
        TextSpan(
          text: '25',
          style: TextStyle(
            color: Color.fromRGBO(42, 176, 211, 1.0),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ));
  }

  static Widget _cu({required double fontSize}) {
    return Text.rich(TextSpan(
      text: 'CU',
      style: TextStyle(
        color: const Color.fromRGBO(160, 199, 59, 1.0),
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
      ),
    ));
  }

  static Widget _emart24({required double fontSize}) {
    return Text.rich(TextSpan(
      style: TextStyle(
        fontSize: fontSize,
      ),
      children: const [
        TextSpan(
          text: '이',
          style: TextStyle(
            color: Color.fromRGBO(250, 157, 43, 1.0),
            fontWeight: FontWeight.w600,
          ),
        ),
        TextSpan(
          text: '마트',
          style: TextStyle(
            color: Color.fromRGBO(62, 61, 61, 1.0),
            fontWeight: FontWeight.w600,
          ),
        ),
        TextSpan(
          text: '24',
          style: TextStyle(
            color: Color.fromRGBO(250, 157, 43, 1.0),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ));
  }

  static Widget _sevenEleven({required double fontSize}) {
    return Text.rich(TextSpan(
      text: '세븐일레븐',
      style: TextStyle(
        color: const Color.fromRGBO(32, 116, 41, 1.0),
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
      ),
    ));
  }

  static Widget _ministop({required double fontSize}) {
    return Text.rich(TextSpan(
      text: '미니스톱',
      style: TextStyle(
        color: const Color.fromRGBO(5, 38, 118, 1.0),
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
      ),
    ));
  }
}
