import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/all.dart';
import './../../management/translation/translation_provider.dart';
import './../../views/homepage/homepage_view.dart';
import './../../views/login/lang_view.dart';
import './../../views/login/states/login_state.dart';
import './../../views/register/register_view.dart';

class LoginForm extends ConsumerWidget {
  LoginForm({Key key}) : super(key: key);

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final translate = watch(translationStateNotifierProvider.state);

    return Scaffold(
      backgroundColor: Colors.green[300],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            translate['title'],
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            translate['login.pick_lang'],
            style: const TextStyle(fontSize: 17),
          ),
          const SizedBox(height: 5),
          FlatButton(
            onPressed: () {
              Navigator.of(context).push<LanguageView>(
                MaterialPageRoute(
                  builder: (context) => const LanguageView(),
                ),
              );
            },
            child: const Text('Choisis la langue'),
          ),
          FormBuilder(
            key: _fbKey,
            child: Column(
              children: <Widget>[
                FormBuilderTextField(
                  name: 'email',
                  decoration: InputDecoration(
                    labelText: translate['login.email'],
                  ),
                  onChanged: (value) {},
                  // valueTransformer: (text) => num.tryParse(text),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                    FormBuilderValidators.email(context),
                  ]),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                ),
                FormBuilderTextField(
                  name: 'mdp',
                  decoration: InputDecoration(
                    labelText: translate['login.mdp'],
                  ),
                  onChanged: (value) {},
                  // valueTransformer: (text) => num.tryParse(text),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                  ]),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  autocorrect: false,
                ),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              const SizedBox(height: 30),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  onPressed: () {
                    if (_fbKey.currentState.saveAndValidate()) {
                      final String identifiant =
                          _fbKey.currentState.fields['email'].value.trim()
                              as String;
                      final String password =
                          _fbKey.currentState.fields['mdp'].value as String;

                      context
                          .read(loginRepository)
                          .login(identifiant, password)
                          .then((status) {
                        if (status) {
                          Navigator.of(context).push<HomepageView>(
                            MaterialPageRoute(
                              builder: (context) => const HomepageView(),
                            ),
                          );
                        }
                      });
                    }
                  },
                  color: Colors.orange[700],
                  child: Text(
                    translate['login.btn_connecter'],
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(
                      color: Colors.orange[700],
                      width: 2,
                    ),
                  ),
                  onPressed: () {
                    if (_fbKey.currentState.saveAndValidate()) {
                      print(_fbKey.currentState.value);
                    }
                  },
                  child: Text(
                    translate['login.btn_enregister'],
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.orange[700],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: translate['login.pwd_forgotten'],
                    ),
                    TextSpan(
                      text: translate['login.click_here'],
                      style: TextStyle(
                        color: Colors.orange[700],
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).push<RegisterView>(
                            MaterialPageRoute(
                              builder: (context) => const RegisterView(),
                            ),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
