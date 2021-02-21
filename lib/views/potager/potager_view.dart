import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import './../../enums/potager_sort_menu_enum.dart';
import './../../management/translation/translation_provider.dart';
import './../../views/homepage/states/nearest_potagers_state.dart';
import './../../views/potager/states/fav_state.dart';
import './../../views/potager/states/filtered_vegetables_state.dart';
import './../../views/potager/states/potager_future.dart';
import './../../views/potager/ui/filtered_menu/fruit_button.dart';
import './../../views/potager/ui/filtered_menu/graine_button.dart';
import './../../views/potager/ui/filtered_menu/legume_button.dart';
import './../../views/potager/ui/filtered_menu/tous_button.dart';
import './../../views/potager/ui/grid/grid_card.dart';

class PotagerView extends ConsumerWidget {
  const PotagerView({Key key, @required this.potagerId}) : super(key: key);

  final int potagerId;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final potager = watch(potagerFuture(potagerId));
    final translate = watch(translationStateNotifierProvider.state);
    final selectedButton = watch(selectedButtonStateProvider).state;

    return Scaffold(
      body: potager.when(
        data: (potager) {
          return Column(
            children: [
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 1.4,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.width,
                      child: Hero(
                        tag: 'potager_${potager.user.username}',
                        child: Image.network(
                          potager.farmer.imgUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SafeArea(
                    right: false,
                    left: false,
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              context.read(selectedButtonStateProvider).state =
                                  SelectedButton.tous;

                              Navigator.of(context).pop();
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color:
                                    const Color.fromRGBO(255, 255, 255, 0.75),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Image.asset(
                                  'assets/icons/picto_retour.png',
                                  color: const Color.fromRGBO(255, 130, 0, 1),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () => print('message'),
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(
                                        255, 255, 255, 0.75),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(6),
                                    child: Image.asset(
                                      'assets/icons/picto_messages.png',
                                      color:
                                          const Color.fromRGBO(255, 130, 0, 1),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              FavButton(
                                potager.farmer.id,
                                potager.farmer.favorite,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    bottom: 15,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 0.75),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 5),
                          Image.asset(
                            'assets/icons/picto_geolocalisation.png',
                            height: 18,
                            width: 18,
                            color: const Color.fromRGBO(50, 159, 91, 1),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            potager.farmer.commune,
                            textScaleFactor: 1.15,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(95, 89, 84, 1),
                            ),
                          ),
                          const SizedBox(width: 5),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      Text(
                        '${translate['potager.title']} ${potager.user.username}',
                        textScaleFactor: 1.5,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 15),
                      descriptionField(potager.farmer.description),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const <Widget>[
                          TousButton(),
                          LegumeButton(),
                          FruitButton(),
                          GraineButton(),
                        ],
                      ),
                      Flexible(
                        child: GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 25,
                          childAspectRatio: 0.65,
                          children: gridCardAliment(selectedButton, potager),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text(err.toString())),
      ),
    );
  }
}

class FavButton extends ConsumerWidget {
  const FavButton(this.farmerId, this.favorite, {Key key}) : super(key: key);
  final int farmerId;
  final bool favorite;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final bool favoriteButton =
        watch(favoriteButtonStateNotifierProvider(favorite).state);

    if (favoriteButton) {
      return InkWell(
        onTap: () async {
          if (await context
              .read(homeRepositoryProvider)
              .deleteFavoritePotager(farmerId)) {
            context.read(favoriteButtonStateProvider).state = !favoriteButton;
          }
        },
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 255, 255, 0.75),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Image.asset(
              'assets/icons/picto_favori_fill.png',
              // 'assets/icons/picto_favori.png',
              color: const Color.fromRGBO(255, 130, 0, 1),
            ),
          ),
        ),
      );
    } else {
      return InkWell(
        onTap: () async {
          if (await context
              .read(homeRepositoryProvider)
              .addFavoritePotager(farmerId)) {
            context.read(favoriteButtonStateProvider).state = !favoriteButton;
          }
        },
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 255, 255, 0.75),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Image.asset(
              // 'assets/icons/picto_favori_fill.png',
              'assets/icons/picto_favori.png',
              color: const Color.fromRGBO(255, 130, 0, 1),
            ),
          ),
        ),
      );
    }
  }
}

Text descriptionField(String description) {
  if (description == null || description.isEmpty) {
    return const Text(
      '~',
      textScaleFactor: 1.5,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Color.fromRGBO(95, 89, 84, 1),
      ),
    );
  }
  return Text(
    description,
    textScaleFactor: 1.1,
    style: const TextStyle(
      color: Color.fromRGBO(95, 89, 84, 1),
    ),
  );
}
