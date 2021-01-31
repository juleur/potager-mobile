import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import '../../management/translation/language_provider.dart';
import './../../views/login/login_form.dart';

class LoginView extends ConsumerWidget {
  const LoginView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final lfp = watch(langueFutureProvider);
    return lfp.when(
      data: (langue) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Container(
            color: Colors.green[300],
            child: SafeArea(
              left: false,
              right: false,
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                child: LoginForm(),
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
