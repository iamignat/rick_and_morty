import 'package:rick_and_morty/feature/domain/entities/origin_entity.dart';

class OriginModel extends OriginEntity {
  const OriginModel({required super.name, required super.url});

  factory OriginModel.fromJson(Map<String, dynamic> json) =>
      OriginModel(name: json['name'], url: json['url']);

  Map<String, dynamic> toJson() => {'name': name, 'url': url};
}
