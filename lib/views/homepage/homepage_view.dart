import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import './../../management/translation/language_provider.dart';
import './../../views/homepage/ui/grid_potagers.part.dart';
import './../../views/homepage/ui/menu.part.dart';
import './../../views/homepage/ui/search_input.part.dart';
import './../../views/homepage/ui/title_grid.part.dart';

class HomepageView extends ConsumerWidget {
  const HomepageView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final lfp = watch(langueFutureProvider);
    return lfp.when(
      data: (langue) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            body: SafeArea(
              bottom: false,
              right: false,
              left: false,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Menu(),
                    SizedBox(height: 20),
                    PotagersInput(),
                    SizedBox(height: 20),
                    TitleGrid(),
                    SizedBox(height: 15),
                    GridPotagers(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => Container(),
    );
  }
}
