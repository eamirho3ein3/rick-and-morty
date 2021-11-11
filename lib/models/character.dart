import 'package:flutter/material.dart';
import 'package:rick_and_morty/global-variable.dart';

class Character {
  final String image;
  final String title;
  final LifeStatus status;
  final String species;
  final String gender;

  Character(
      {@required this.image,
      @required this.title,
      @required this.status,
      @required this.species,
      @required this.gender});

  static List<Character> fromJson(Map<String, Object> json) {
    List<Character> results = [];
    GlobVariable().setCharacterListStatus(
        (json['info'] as Map<dynamic, dynamic>)['next'] != null);
    List<dynamic> dataResults = json['results'] as List<dynamic>;
    for (var item in dataResults) {
      results.add(Character(
        image: item["image"] as String,
        title: item["name"] as String,
        status: item["status"] as String == 'Alive'
            ? LifeStatus.Alive
            : item["status"] as String == 'Dead'
                ? LifeStatus.Dead
                : LifeStatus.Unknown,
        species: item["species"] as String,
        gender: item["gender"] as String,
      ));
    }

    return results;
  }
}

enum LifeStatus { Alive, Dead, Unknown }
