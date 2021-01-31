import 'package:meta/meta.dart';

enum UniteMesure {
  botte,
  kilogramme,
  piece,
}

extension UniteMesureExtension on UniteMesure {
  static const names = {
    UniteMesure.botte: 'Botte',
    UniteMesure.kilogramme: 'Kg',
    UniteMesure.piece: 'Piece'
  };

  String get name => names[this];
  UniteMesure find(String unit) {
    for (final u in UniteMesure.values) {
      if (u.name == unit) {
        return u;
      }
    }
    return UniteMesure.piece;
  }
}

enum SystemeEchange {
  don,
  troc,
  vente,
}

extension SystemeEchangeExtension on SystemeEchange {
  static const names = {
    SystemeEchange.don: 'Don',
    SystemeEchange.troc: 'Troc',
    SystemeEchange.vente: 'Vente',
  };

  String get name => names[this];
}

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
    UniteMesure unit;
    for (final u in UniteMesure.values) {
      if (u.name == json['uniteMesure']) unit = u;
    }
    final List<SystemeEchange> systemeEchange = [];

    for (final v in json['systemeEchange'] as List<dynamic>) {
      for (final se in SystemeEchange.values) {
        if (se.name == v) systemeEchange.add(se);
      }
    }

    return Aliment(
      id: json['id'] as int,
      imgUrl: json['imgUrl'] != null ? json['imgUrl'] as String : null,
      nom: json['nom'] as String,
      variete: json['variete'] as String,
      uniteMesure: unit,
      systemeEchange: systemeEchange,
      prix: json['prix'] != null ? json['prix'] as double : null,
      stock: json['stock'] as int,
    );
  }

  final int id;
  final String imgUrl;
  final String nom;
  final String variete;
  final UniteMesure uniteMesure;
  final List<SystemeEchange> systemeEchange;
  final double prix;
  final int stock;
}
