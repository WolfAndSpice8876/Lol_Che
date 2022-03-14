import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lol/dto/item_dto.dart';

class ItemDataBase {
  static List<ItemDto> data = <ItemDto>[];

  static Future<void> get()async{
    List<ItemDto> result = <ItemDto>[];
    String jsonString = await rootBundle.loadString("json_data/item.json");
    final itemData = jsonDecode(jsonString)['data'] as List<dynamic>;

    itemData.forEach((element) {
      List<int> materialList = new List<int>.from(element['Materials']);

      result.add(ItemDto(
          koreanName: element['KoreanName'],
          index: element["Index"],
          isComplete: element['IsComplete'],
          materials: materialList,
          description: element['Description']
      ));
    });

    data = result;
    return;
  }
}
