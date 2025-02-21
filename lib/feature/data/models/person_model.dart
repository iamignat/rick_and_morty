import 'package:rick_and_morty/feature/data/models/location_model.dart';
import 'package:rick_and_morty/feature/data/models/origin_model.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';

class PersonModel extends PersonEntity {
  const PersonModel(
      {required super.id,
      required super.name,
      required super.status,
      required super.species,
      required super.type,
      required super.gender,
      required super.origin,
      required super.location,
      required super.image,
      required super.episode,
      required super.url,
      required super.created});

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      type: json['type'],
      gender: json['gender'],
      origin: OriginModel.fromJson(
        json['origin'],
      ),
      location: LocationModel.fromJson(
        json['location'],
      ),
      image: json['image'],
      episode: List<String>.from(
        json['episode'].map((x) => x),
      ),
      url: json['url'],
      created: DateTime.parse(
        json['created'],
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'status': status,
        'species': species,
        'type': type,
        'gender': gender,
        'origin': origin,
        'location': location,
        'image': image,
        'episode': episode,
        'url': url,
        'created': created.toString(),
      };
}
