import 'package:flutter/material.dart';
import 'package:rick_and_morty/models/character.dart';
import 'package:rick_and_morty/services/api/api.dart';
import 'package:rick_and_morty/services/api/api_list.dart';
import 'package:rick_and_morty/services/global-variable.dart';

class HomeRepository {
  Future<List<Character>> getCharacters(
      BuildContext context, int page, String? searchText) async {
    var queryParameters = searchText == null
        ? {"page": page.toString()}
        : {"page": page.toString(), "name": searchText};

    var response = await AppApi.defaultApiClient
        .get(character, queryParameters: queryParameters);
    GlobVariable().setCharacterListStatus(
        (response.data['info'] as Map<String, dynamic>)['next'] != null);

    return List<Map<String, dynamic>>.from(
            response.data['results'] as List<dynamic>)
        .map((e) => Character.fromJson(e))
        .toList();
  }
}
