import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import './../../../management/dialog/flushbar_state_notifier.dart';
import './../../../management/messenger/messenger_service_provider.dart';
import './../../../management/translation/translation_provider.dart';
import './../../../views/homepage/states/anti_spam_geo_state.dart';
import './../../../views/homepage/states/geo_commune_state.dart';

class Menu extends StatelessWidget {
  const Menu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const <Widget>[
          MenuButton(),
          Geolocalisation(),
          RightButtons(),
        ],
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  const MenuButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        print('MenuButton');
      },
      child: Image.asset(
        'assets/icons/picto_menu.png',
        height: 33,
        width: 33,
      ),
    );
  }
}

class Geolocalisation extends StatelessWidget {
  const Geolocalisation({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () async {
            if (await context
                .read(antiSpamGeoStateNotifierProvider)
                .allowed()) {
              await context
                  .read(communeStateNotifierProvider)
                  .fetchCommuneName();
            }
          },
          child: Image.asset(
            'assets/icons/picto_geolocalisation.png',
            height: 35,
            width: 35,
            color: const Color.fromRGBO(50, 159, 91, 1),
          ),
        ),
        const SizedBox(width: 6),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 180),
          child: Consumer(
            builder: (_, watch, __) {
              final String commune = watch(communeStateNotifierProvider.state);
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  commune,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class RightButtons extends StatelessWidget {
  const RightButtons({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const <Widget>[
        MessageButton(),
        SizedBox(width: 8),
        ProfilButton(),
      ],
    );
  }
}

class MessageButton extends ConsumerWidget {
  const MessageButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final translate = watch(translationStateNotifierProvider);
    return InkWell(
      onTap: () async {
        if (!await context.read(messengerServiceProvider).isVerified()) {
          context.read(messageStateProvider).state = translate.verifiedMessage;
        }
      },
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(255, 255, 255, 1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                'assets/icons/picto_messages.png',
                height: 20,
                width: 20,
                color: const Color.fromRGBO(255, 130, 0, 1),
              ),
            ),
          ),
          Positioned(
            top: -7,
            right: -5,
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 0, 0, 1),
                shape: BoxShape.circle,
                border: Border.all(
                  width: 1.5,
                  color: Colors.white,
                ),
              ),
              child: const Center(
                child: Text(
                  '2',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProfilButton extends StatelessWidget {
  const ProfilButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => print('ProfilButton'),
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 255, 255, 1),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Image.asset(
            'assets/icons/picto_profil.png',
            height: 20,
            width: 20,
            color: const Color.fromRGBO(255, 130, 0, 1),
          ),
        ),
      ),
    );
  }
}
