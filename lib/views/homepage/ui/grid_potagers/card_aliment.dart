import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import './../../../../management/translation/translation_provider.dart';
import './../../../../models/nearest_aliment_model.dart';
import './../../../../views/potager/potager_view.dart';
import './../../../../views/shared/card_aliment/aliment_info_part.dart';
import './../../../../views/shared/card_aliment/echange_part.dart';

class CardAliment extends ConsumerWidget {
  const CardAliment(this._na, {Key key}) : super(key: key);

  final NearestAliment _na;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final translate = watch(translationStateNotifierProvider.state);

    return InkWell(
      onTap: () async => Navigator.push(
        context,
        MaterialPageRoute<PotagerView>(
          builder: (context) => PotagerView(potagerId: _na.user.id),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromRGBO(255, 255, 255, 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Hero(
                tag: 'potager_${_na.user.username}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    'https://placeimg.com/640/480/any',
                    height: 120,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
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
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    _na.aliment.variete.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icons/picto_geolocalisation.png',
                      width: 20,
                      height: 20,
                      color: const Color.fromRGBO(50, 159, 91, 1),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      _na.farmer.commune,
                      textScaleFactor: 1.1,
                    ),
                  ],
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
                  (index) =>
                      EchangeSystemeField(_na.aliment.systemeEchange[index]),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: alimentInfo(
                systemEchange: _na.aliment.systemeEchange,
                stock: _na.aliment.stock,
                price: _na.aliment.prix,
                uniteMesure: _na.aliment.uniteMesure,
                translate: translate,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
