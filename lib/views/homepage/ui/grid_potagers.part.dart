import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import './../../../management/translation/translation_provider.dart';
import './../../homepage/ui/grid_potagers/card_potager.dart';
import './../states/nearest_aliments_state.dart';
import './../states/nearest_potagers_state.dart';
import './../states/search_bar_state.dart';
import './grid_potagers/card_aliment.dart';

class GridPotagers extends ConsumerWidget {
  const GridPotagers({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final translate = watch(translationStateNotifierProvider.state);
    final searchBarStatus = watch(searchBarProvider);

    if (searchBarStatus.state == SearchBarStatus.active) {
      final nearestAliments = watch(nearestAlimentsFuture);

      return nearestAliments.when(
        data: (nearestAliments) {
          if (nearestAliments.isEmpty) {
            return Expanded(
              child: Column(
                children: [
                  const Spacer(),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      translate['aliment.aucun'],
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            );
          }
          return Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 25,
              childAspectRatio: 0.60,
              children: [
                for (final na in nearestAliments) CardAliment(na),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => const Text('Oops'),
      );
    }
    final nearestPotagers = watch(nearestPotagerFuture);
    return nearestPotagers.when(
      data: (nearestPotagers) {
        if (nearestPotagers.isEmpty) {
          return Expanded(
            child: Column(
              children: [
                const Spacer(),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    translate['potager.aucun'],
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                const Spacer(flex: 2),
              ],
            ),
          );
        }
        return Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 25,
            childAspectRatio: 0.64,
            children: [
              for (final np in nearestPotagers) CardPotager(np),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) {
        return Container();
      },
    );
  }
}
