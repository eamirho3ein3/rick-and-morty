import 'package:flutter/material.dart';
import 'package:rick_and_morty/dio-client.dart';
import 'package:rick_and_morty/models/character.dart';

class HomeRepository {
  Future<dynamic> getCharacters(BuildContext context, int page,
      String searchText, DioClient client) async {
    var parameters = searchText == null
        ? {"page": page.toString()}
        : {
            "page": page.toString(),
            "name": searchText != null ? searchText : ''
          };
    final response =
        await client.get(context: context, queryParameters: parameters);
    return Character.fromJson(response.data);
  }
}
