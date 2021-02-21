import 'dart:convert';
import 'package:meta/meta.dart';

class Farmer {
  Farmer({
    @required this.id,
    this.imgUrl,
    this.description,
    this.commune,
    this.coordonnees,
    this.favorite,
  });

  factory Farmer.fromJson(Map<String, dynamic> json) {
    return Farmer(
      id: json['id'] as int,
      imgUrl: json['imgUrl'] as String,
      description: json['description'] as String,
      commune: json['commune'] as String,
      coordonnees: [],
      favorite: json['favorite'] as bool,
    );
  }

  @override
  String toString() {
    return '{id: $id, imgUrl: $imgUrl, description: $description, commune: $commune, coordonnees: $coordonnees, favorite: $favorite}';
  }

  final int id;
  final String imgUrl;
  final String description;
  final String commune;
  final List<double> coordonnees;
  final bool favorite;
}
