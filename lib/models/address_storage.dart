import 'dart:convert';

class Address {
  Address({
    this.numero,
    this.rue,
    this.ville,
    this.village,
    this.lieuDit,
    this.codePostal,
    this.geo,
  });

  factory Address.fromJson(String json) {
    final Map<String, dynamic> rawJson = jsonDecode(json);
    return Address(
      numero: 1,
      rue: '',
      ville: '',
      village: '',
      lieuDit: '',
      codePostal: 45555,
      geo: [],
    );
  }

  final int numero;
  final String rue;
  final String ville;
  final String village;
  final String lieuDit;
  final int codePostal;
  final List<double> geo;
}
