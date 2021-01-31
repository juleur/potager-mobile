import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flushbar/flushbar.dart';
import './../enums/user_status_enum.dart';
import './../management/authentication/user_status_future.dart';
import './../management/dialog/flushbar_state_notifier.dart';
import './../views/homepage/homepage_view.dart';
import './../views/login/login_view.dart';

class BootstrapView extends StatelessWidget {
  const BootstrapView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<StateController<String>>(
      onChange: (context, msg) {
        if (msg.state != '') {
          Flushbar<String>(
            flushbarPosition: FlushbarPosition.TOP,
            message: msg.state,
            duration: const Duration(milliseconds: 2500),
          ).show(context);
        }
      },
      provider: messageStateProvider,
      child: const StarterView(),
    );
  }
}

class StarterView extends ConsumerWidget {
  const StarterView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final usfp = watch(userStatusFutureProvider);
    return usfp.when(
      data: (status) {
        switch (status) {
          case UserStatus.loggedIn:
            return const HomepageView();
          case UserStatus.notloggedIn:
            return const LoginView();
          default:
            return const RestartApplicationWidget();
        }
      },
      loading: () {
        return Scaffold(
          body: Container(
            color: Colors.green[300],
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
      error: (e, _) => const RestartApplicationWidget(),
    );
  }
}

class RestartApplicationWidget extends ConsumerWidget {
  const RestartApplicationWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          child: Column(
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  print('il faut supprimer le storage dans ce cas ci');
                },
                child: const Text('Rédémarez votre application'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
