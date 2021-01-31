import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import './../../enums/language_enum.dart';
import './../../management/translation/language_storage_provider.dart';
import './../../management/translation/translation_provider.dart';

class LanguageView extends ConsumerWidget {
  const LanguageView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final translate = watch(translationStateNotifierProvider.state);

    return Scaffold(
      backgroundColor: Colors.blue[400],
      body: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: Column(
          children: [
            RaisedButton(
              onPressed: () async {
                context
                    .read(languageStorageStateNotifierProvider)
                    .updateLanguage(Language.francais);
                Navigator.pop(context);
              },
              child: Text(translate['lang.francais']),
            ),
            RaisedButton(
              onPressed: () async {
                context
                    .read(languageStorageStateNotifierProvider)
                    .updateLanguage(Language.basque);
                Navigator.pop(context);
              },
              child: Text(translate['lang.basque']),
            ),
            RaisedButton(
              onPressed: () async {
                context
                    .read(languageStorageStateNotifierProvider)
                    .updateLanguage(Language.corse);
                Navigator.pop(context);
              },
              child: Text(translate['lang.corse']),
            ),
          ],
        ),
      ),
    );
  }
}
