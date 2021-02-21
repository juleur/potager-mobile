import 'package:potager/models/farmer_model.dart';

import './../models/user_model.dart';

class Potager {
  Potager({
    this.user,
    this.farmer,
    this.fruits,
    this.legumes,
    this.graines,
  });

  factory Potager.fromJson(Map<String, dynamic> json) {
    final user = User.fromJson(json['user']);
    final farmer = Farmer.fromJson(json['farmer']);

    final List<Fruit> fruits = json['fruits'] != null
        ? (json['fruits'] as List<dynamic>)
            .map((f) => Fruit.fromJson(f))
            .toList()
        : [];

    final List<Graine> graines = json['graines'] != null
        ? (json['graines'] as List<dynamic>)
            .map((g) => Graine.fromJson(g))
            .toList()
        : [];

    final List<Legume> legumes = json['legumes'] != null
        ? (json['legumes'] as List<dynamic>)
            .map((l) => Legume.fromJson(l))
            .toList()
        : [];

    return Potager(
      user: user,
      farmer: farmer,
      fruits: fruits,
      graines: graines,
      legumes: legumes,
    );
  }

  @override
  String toString() =>
      '{user: ${user.toString()}, fruits: ${fruits.toString()}, graines: ${graines.toString()}, legumes: ${legumes.toString()}}';

  final User user;
  final Farmer farmer;
  final List<Fruit> fruits;
  final List<Legume> legumes;
  final List<Graine> graines;
}

class Fruit {
  Fruit({
    this.id,
    this.imgUrl,
    this.nom,
    this.variete,
    this.systemeEchange,
    this.prix,
    this.uniteMesure,
    this.stock,
  });

  factory Fruit.fromJson(Map<String, dynamic> json) {
    final List<int> se =
        (json['systemeEchange'] as List<dynamic>).map((v) => v as int).toList();

    return Fruit(
      id: json['id'] as int,
      imgUrl: json['imgUrl'] as String,
      nom: json['nom'] as String,
      variete: json['variete'] as String,
      systemeEchange: se,
      prix: json['prix'] as double,
      uniteMesure: json['uniteMesure'] as int,
      stock: json['stock'] as int,
    );
  }

  @override
  String toString() =>
      '{id: $id, imgUrl: $imgUrl, nom: $nom, variete: $variete, systemeEchange: $systemeEchange, prix: $prix, uniteMesure: $uniteMesure, stock: $stock}';

  final int id;
  final String imgUrl;
  final String nom;
  final String variete;
  final List<int> systemeEchange;
  final double prix;
  final int uniteMesure;
  final int stock;
}

class Graine {
  Graine({
    this.id,
    this.imgUrl,
    this.nom,
    this.variete,
    this.systemeEchange,
    this.prix,
    this.stock,
  });

  factory Graine.fromJson(Map<String, dynamic> json) {
    final List<int> se = (json['systemeEchange'] as List<dynamic>)
            .map((v) => v as int)
            .toList() ??
        [];

    return Graine(
      id: json['id'] as int,
      imgUrl: json['imgUrl'] as String,
      nom: json['nom'] as String,
      variete: json['variete'] as String,
      systemeEchange: se,
      prix: json['prix'] as double,
      stock: json['stock'] as int,
    );
  }

  @override
  String toString() =>
      '{id: $id, imgUrl: $imgUrl, nom: $nom, variete: $variete, systemeEchange: $systemeEchange, prix: $prix, stock: $stock}';

  final int id;
  final String imgUrl;
  final String nom;
  final String variete;
  final List<int> systemeEchange;
  final double prix;
  final int stock;
}

class Legume {
  Legume({
    this.id,
    this.imgUrl,
    this.nom,
    this.variete,
    this.systemeEchange,
    this.prix,
    this.uniteMesure,
    this.stock,
  });

  factory Legume.fromJson(Map<String, dynamic> json) {
    final List<int> se =
        (json['systemeEchange'] as List<dynamic>).map((v) => v as int).toList();

    return Legume(
      id: json['id'] as int,
      imgUrl: json['imgUrl'] as String,
      nom: json['nom'] as String,
      variete: json['variete'] as String,
      systemeEchange: se,
      prix: json['prix'] as double,
      uniteMesure: json['uniteMesure'] as int,
      stock: json['stock'] as int,
    );
  }

  @override
  String toString() =>
      '{id: $id, imgUrl: $imgUrl, nom: $nom, variete: $variete, systemeEchange: $systemeEchange, prix: $prix, uniteMesure: $uniteMesure, stock: $stock}';

  final int id;
  final String imgUrl;
  final String nom;
  final String variete;
  final List<int> systemeEchange;
  final double prix;
  final int uniteMesure;
  final int stock;
}
