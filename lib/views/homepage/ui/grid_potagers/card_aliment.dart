import 'package:flutter/material.dart';
import './../../../../models/aliment_model.dart';
import './../../../../models/nearest_aliment_model.dart';

class CardAliment extends StatelessWidget {
  const CardAliment(
    this._na, {
    Key key,
  }) : super(key: key);

  final NearestAliment _na;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromRGBO(255, 255, 255, 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                'https://placeimg.com/640/480/any',
                height: 120,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Align(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                _na.aliment.nom[0].toUpperCase() +
                    _na.aliment.nom.substring(1).toLowerCase(),
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
          Align(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                _na.aliment.variete.toUpperCase(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                _na.aliment.systemeEchange.length,
                (index) => Echange(_na.aliment.systemeEchange[index]),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: _alimentInfo(_na.aliment),
          ),
        ],
      ),
    );
  }
}

Widget _alimentInfo(Aliment aliment) {
  if (aliment.systemeEchange.contains(SystemeEchange.don)) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset(
          'assets/icons/picto_brouette.png',
          height: 35,
          width: 35,
          color: _colorStock(aliment.stock),
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
              text: aliment.uniteMesure.name,
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
        color: _colorStock(aliment.stock),
      ),
    ],
  );
}

class Echange extends StatelessWidget {
  const Echange(
    this._sp, {
    Key key,
  }) : super(key: key);

  final SystemeEchange _sp;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: _colorSystemEchange(_sp),
      ),
      height: 20,
      width: 60,
      child: Center(
        child: Text(
          _sp.name,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

Color _colorSystemEchange(SystemeEchange sp) {
  switch (sp.name) {
    case 'Don':
      return const Color.fromRGBO(50, 159, 91, 1);
    case 'Troc':
      return const Color.fromRGBO(255, 99, 71, 1);
    case 'Vente':
      return const Color.fromRGBO(98, 87, 255, 1);
  }
  return const Color.fromRGBO(255, 255, 255, 1);
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
