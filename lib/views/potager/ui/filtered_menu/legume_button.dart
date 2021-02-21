import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:potager/management/translation/translation_provider.dart';
import './../../../../enums/potager_sort_menu_enum.dart';
import './../../../../views/potager/states/filtered_vegetables_state.dart';

class LegumeButton extends ConsumerWidget {
  const LegumeButton({Key key}) : super(key: key);
  static const String buttonName = 'LEGUMES';

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final translate = watch(translationStateNotifierProvider.state);
    final selectedButton = watch(selectedButtonStateProvider).state;

    return Column(
      children: [
        InkWell(
          onTap: () async {
            context.read(selectedButtonStateProvider).state =
                SelectedButton.legumes;
          },
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(255, 255, 255, 1),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              border: Border.all(
                style: selectedButton.name == buttonName
                    ? BorderStyle.solid
                    : BorderStyle.none,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.asset(
                'assets/icons/picto_legumes.png',
                color: selectedButton.name == buttonName
                    ? const Color.fromRGBO(255, 130, 0, 1)
                    : const Color.fromRGBO(81, 60, 44, 1),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          translate['potager.menu_legumes'],
          style: TextStyle(
            fontWeight: selectedButton.name == buttonName
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
