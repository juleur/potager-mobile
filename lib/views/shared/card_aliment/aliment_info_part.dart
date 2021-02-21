import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

Widget alimentInfo({
  @required List<int> systemEchange,
  @required int stock,
  @required double price,
  int uniteMesure,
  @required Map<String, String> translate,
}) {
  if (systemEchange.contains([0, 1, 2])) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset(
          'assets/icons/picto_brouette.png',
          height: 35,
          width: 35,
          color: _colorStock(stock),
        ),
      ],
    );
  }

  if (uniteMesure == null) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset(
          'assets/icons/picto_brouette.png',
          height: 35,
          width: 35,
          color: _colorStock(stock),
        ),
      ],
    );
  }
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Text.rich(
        TextSpan(
          children: [
            const TextSpan(
              text: '3.40 €',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const TextSpan(text: '/', style: TextStyle(letterSpacing: 8)),
            TextSpan(
              text: _translaterUniteMesure(translate, uniteMesure),
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      Image.asset(
        'assets/icons/picto_brouette.png',
        height: 35,
        width: 35,
        color: _colorStock(stock),
      ),
    ],
  );
}

String _translaterUniteMesure(Map<String, String> translate, int uniteMesure) {
  switch (uniteMesure) {
    case 0:
      return translate['potager.botte'];
    case 1:
      return 'Kg';
    case 2:
      return translate['potager.piece'];
  }
  return 'Kg';
}

Color _colorStock(int stock) {
  switch (stock) {
    case 0:
      // épuisé
      return const Color.fromRGBO(217, 215, 215, 1);
    case 1:
      // peu
      return const Color.fromRGBO(255, 143, 16, 1);
    case 2:
      // disponible
      return const Color.fromRGBO(33, 206, 90, 1);
  }
  return const Color.fromRGBO(33, 206, 90, 1);
}
