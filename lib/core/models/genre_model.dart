import 'package:flicknova/core/models/genre_entity.dart';

class GenreModel  extends GenreEntity{
  GenreModel({
    required super.id,
    required super.name,
});
  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

 Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
 }
}