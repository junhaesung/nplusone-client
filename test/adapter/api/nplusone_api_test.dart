import 'dart:convert';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:nplusone/adapter/api/dto/api_response.dart';
import 'package:nplusone/adapter/api/dto/item_response.dart';
import 'package:nplusone/adapter/api/nplusone_api.dart';

void main() {
  NplusoneApi sut = const NplusoneApi();

  test('getItems: data', () async {
    final actual = await sut.getItems();
    expect(actual.data?.length, 20);
    expect(actual.data?.first.itemId != null, true);
  });

  test('getItems: hasNext', () async {
    final actual = await sut.getItems();
    expect(actual.hasNext, true);
  });

  test('getItems: offsetId', () async {
    final actual = await sut.getItems();
    expect(actual.offsetId != null, true);
  });

}