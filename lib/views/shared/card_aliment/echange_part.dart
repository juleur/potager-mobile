import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import './../../../management/translation/translation_provider.dart';

class EchangeSystemeField extends ConsumerWidget {
  const EchangeSystemeField(this._sp, {Key key}) : super(key: key);
  final int _sp;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final translate = watch(translationStateNotifierProvider.state);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: _colorSystemEchange(_sp),
      ),
      height: 20,
      width: 68,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 3.0, right: 3.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              translaterSystemeEchange(translate, _sp),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

String translaterSystemeEchange(Map<String, String> translate, int sp) {
  switch (sp) {
    case 0:
      return translate['potager.don'];
    case 1:
      return translate['potager.troc'];
    case 2:
      return translate['potager.vente'];
  }
  return translate['potager.vente'];
}

Color _colorSystemEchange(int sp) {
  switch (sp) {
    case 0:
      return const Color.fromRGBO(50, 159, 91, 1);
    case 1:
      return const Color.fromRGBO(255, 99, 71, 1);
    case 2:
      return const Color.fromRGBO(98, 87, 255, 1);
  }
  return const Color.fromRGBO(255, 255, 255, 1);
}
