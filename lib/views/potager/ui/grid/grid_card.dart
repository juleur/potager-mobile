import 'package:flutter/material.dart';
import '../../../../enums/potager_sort_menu_enum.dart';
import '../../../../models/potager_model.dart';
import 'card_aliment.dart';

List<Widget> gridCardAliment(SelectedButton selectedButton, Potager potager) {
  List<CardAliment> widgets = [];
  switch (selectedButton) {
    case SelectedButton.fruits:
      widgets.addAll(
        potager.fruits
            .map(
              (f) => CardAliment(
                id: f.id,
                imgUrl: f.imgUrl,
                nom: f.nom,
                variete: f.variete,
                systemeEchange: f.systemeEchange,
                prix: f.prix,
                uniteMesure: f.uniteMesure,
                stock: f.stock,
              ),
            )
            .toList(),
      );
      return widgets;
    case SelectedButton.graines:
      widgets.addAll(
        potager.graines
            .map(
              (g) => CardAliment(
                id: g.id,
                imgUrl: g.imgUrl,
                nom: g.nom,
                variete: g.variete,
                systemeEchange: g.systemeEchange,
                prix: g.prix,
                stock: g.stock,
              ),
            )
            .toList(),
      );
      return widgets;
    case SelectedButton.legumes:
      widgets.addAll(
        potager.legumes
            .map(
              (l) => CardAliment(
                id: l.id,
                imgUrl: l.imgUrl,
                nom: l.nom,
                variete: l.variete,
                systemeEchange: l.systemeEchange,
                prix: l.prix,
                uniteMesure: l.uniteMesure,
                stock: l.stock,
              ),
            )
            .toList(),
      );
      return widgets;
    default:
      widgets.addAll(
        potager.fruits
            .map(
              (f) => CardAliment(
                id: f.id,
                imgUrl: f.imgUrl,
                nom: f.nom,
                variete: f.variete,
                systemeEchange: f.systemeEchange,
                prix: f.prix,
                uniteMesure: f.uniteMesure,
                stock: f.stock,
              ),
            )
            .toList(),
      );
      widgets.addAll(
        potager.graines
            .map(
              (g) => CardAliment(
                id: g.id,
                imgUrl: g.imgUrl,
                nom: g.nom,
                variete: g.variete,
                systemeEchange: g.systemeEchange,
                prix: g.prix,
                stock: g.stock,
              ),
            )
            .toList(),
      );
      widgets.addAll(
        potager.legumes
            .map(
              (l) => CardAliment(
                id: l.id,
                imgUrl: l.imgUrl,
                nom: l.nom,
                variete: l.variete,
                systemeEchange: l.systemeEchange,
                prix: l.prix,
                uniteMesure: l.uniteMesure,
                stock: l.stock,
              ),
            )
            .toList(),
      );
      widgets.shuffle();
      return widgets;
  }
}
