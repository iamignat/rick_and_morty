import 'dart:convert';

import 'package:rick_and_morty/core/error/exception.dart';
import 'package:rick_and_morty/feature/data/models/person_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PersonLocalDataSource {
  Future<List<PersonModel>> getLastPersonsFromCache();
  Future<void> personsToCache(List<PersonModel> persons);
}

const cachedPersons = 'CACHED_PERSONS';

class PersonLocalDataSourceImpl implements PersonLocalDataSource {
  final SharedPreferences sharedPreferences;

  PersonLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<List<PersonModel>> getLastPersonsFromCache() {
    final jsonPersonsList = sharedPreferences.getStringList(cachedPersons);
    if (jsonPersonsList != null && jsonPersonsList.isNotEmpty) {
      return Future.value(jsonPersonsList
          .map((person) => PersonModel.fromJson(jsonDecode(person)))
          .toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future<List<String>> personsToCache(List<PersonModel> persons) {
    final List<String> jsonPersonsList =
        persons.map((person) => jsonEncode(person.toJson())).toList();
    sharedPreferences.setStringList(cachedPersons, jsonPersonsList);
    return Future.value(jsonPersonsList);
  }
}
