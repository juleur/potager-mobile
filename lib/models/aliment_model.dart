import 'package:meta/meta.dart';

class Aliment {
  Aliment({
    @required this.id,
    this.imgUrl,
    @required this.nom,
    @required this.variete,
    this.uniteMesure,
    @required this.systemeEchange,
    this.prix,
    @required this.stock,
  });

  factory Aliment.fromJson(Map<String, dynamic> json) {
    final List<int> se =
        (json['systemeEchange'] as List<dynamic>).map((v) => v as int).toList();

    return Aliment(
      id: json['id'] as int,
      imgUrl: json['imgUrl'] != null ? json['imgUrl'] as String : null,
      nom: json['nom'] as String,
      variete: json['variete'] as String,
      uniteMesure: json['uniteMesure'] as int,
      systemeEchange: se,
      prix: json['prix'] != null ? json['prix'] as double : null,
      stock: json['stock'] as int,
    );
  }

  @override
  String toString() =>
      '{id: $id, imgUrl: $imgUrl, nom: $nom, variete: $variete, uniteMesure: $uniteMesure, systemeEchange: $systemeEchange, prix: $prix, stock: $stock}';

  final int id;
  final String imgUrl;
  final String nom;
  final String variete;
  final int uniteMesure;
  final List<int> systemeEchange;
  final double prix;
  final int stock;
}
