import 'package:flutter_riverpod/all.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import './../../../../management/translation/translation_provider.dart';
import './../../../shared/card_aliment/aliment_info_part.dart';
import './../../../shared/card_aliment/echange_part.dart';

class CardAliment extends ConsumerWidget {
  const CardAliment({
    @required this.id,
    @required this.imgUrl,
    @required this.nom,
    @required this.variete,
    @required this.systemeEchange,
    @required this.prix,
    this.uniteMesure,
    @required this.stock,
    Key key,
  }) : super(key: key);
  final int id;
  final String imgUrl;
  final String nom;
  final String variete;
  final List<int> systemeEchange;
  final double prix;
  final int uniteMesure;
  final int stock;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final translate = watch(translationStateNotifierProvider.state);

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
                nom[0].toUpperCase() + nom.substring(1).toLowerCase(),
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
                  variete.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
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
                systemeEchange.length,
                (index) => EchangeSystemeField(systemeEchange[index]),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: alimentInfo(
              systemEchange: systemeEchange,
              stock: stock,
              price: prix,
              uniteMesure: uniteMesure,
              translate: translate,
            ),
          ),
        ],
      ),
    );
  }
}
