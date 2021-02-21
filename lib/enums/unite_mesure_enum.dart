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
}

UniteMesure convertUniteMesure(String uniteMesure) {
  for (final u in UniteMesure.values) {
    if (u.name == uniteMesure) {
      return u;
    }
  }
  return UniteMesure.piece;
}
