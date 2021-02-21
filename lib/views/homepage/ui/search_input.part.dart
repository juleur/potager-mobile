import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/all.dart';
import './../../../management/translation/translation_provider.dart';
import './../../../views/homepage/states/nearest_aliments_state.dart';
import './../../../views/homepage/states/search_bar_state.dart';

class PotagersInput extends ConsumerWidget {
  const PotagersInput({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final naStateNotifier = watch(nearestAlimentsStateNotifier);
    final translate = watch(translationStateNotifierProvider.state);

    return Container(
      height: 50,
      margin: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color.fromRGBO(255, 255, 255, 1),
      ),
      child: TextField(
        onChanged: (text) {
          if (text.length >= 3) {
            context.read(searchBarProvider).state = SearchBarStatus.active;
            naStateNotifier.search(text.trim().toLowerCase());
          }
          if (text.isEmpty) {
            context.read(searchBarProvider).state = SearchBarStatus.inactive;
            context.read(nearestAlimentsStateNotifier).resetState();
          }
        },
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
        ],
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: translate['potager.search_placeholder'],
          // errorText: 'test',
          suffixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/icons/picto_recherche.png',
              color: const Color.fromRGBO(255, 130, 0, 1),
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
        ),
      ),
    );
  }
}
