import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import '../../../management/translation/translation_provider.dart';

class TitleGrid extends ConsumerWidget {
  const TitleGrid({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final translate = watch(translationStateNotifierProvider.state);

    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        translate['potager.titre'],
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: Color.fromRGBO(81, 60, 44, 1),
        ),
      ),
    );
  }
}
