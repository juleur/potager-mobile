import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import './../../../../management/translation/translation_provider.dart';
import './../../../../models/nearest_potager_model.dart';
import './../../../potager/potager_view.dart';
import './.././../../../views/homepage/states/nearest_potagers_state.dart';

//ignore: must_be_immutable
class CardPotager extends ConsumerWidget {
  const CardPotager(this._np, {Key key}) : super(key: key);

  final NearestPotager _np;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final translate = watch(translationStateNotifierProvider.state);

    return InkWell(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute<PotagerView>(
            builder: (context) => PotagerView(potagerId: _np.farmer.id),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromRGBO(255, 255, 255, 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Hero(
                tag: 'potager_${_np.user.username}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    _np.farmer.imgUrl,
                    height: 120,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Potager de ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: _np.user.username,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icons/picto_geolocalisation.png',
                      width: 20,
                      height: 20,
                      color: const Color.fromRGBO(50, 159, 91, 1),
                    ),
                    const SizedBox(width: 3),
                    Text(_np.farmer.commune),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          getIcon(_np.fruitsCount),
                          Text(translate['potager.menu_fruits']),
                        ],
                      ),
                      Row(
                        children: [
                          getIcon(_np.legumesCount),
                          Text(translate['potager.menu_legumes']),
                        ],
                      ),
                      Row(
                        children: [
                          getIcon(_np.grainesCount),
                          Text(translate['potager.menu_graines']),
                        ],
                      )
                    ],
                  ),
                  const Spacer(),
                  FavoriteButton(
                    _np.farmer.id,
                    _np.farmer.favorite,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

//ignore: must_be_immutable
class FavoriteButton extends StatefulWidget {
  FavoriteButton(this.farmerId, this.favorite, {Key key}) : super(key: key);
  final int farmerId;
  bool favorite;

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  Widget build(BuildContext context) {
    if (widget.favorite) {
      return InkWell(
        onTap: () async {
          if (await context
              .read(homeRepositoryProvider)
              .deleteFavoritePotager(widget.farmerId)) {
            setState(() {
              widget.favorite = !widget.favorite;
            });
          }
        },
        child: Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color.fromRGBO(255, 130, 0, 1),
            ),
            color: const Color.fromRGBO(255, 255, 255, 1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/icons/picto_favori_fill.png',
              color: const Color.fromRGBO(255, 130, 0, 1),
            ),
          ),
        ),
      );
    } else {
      return InkWell(
        onTap: () async {
          if (await context
              .read(homeRepositoryProvider)
              .addFavoritePotager(widget.farmerId)) {
            setState(() {
              widget.favorite = !widget.favorite;
            });
          }
        },
        child: Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromRGBO(255, 130, 0, 1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/icons/picto_favori.png',
              color: const Color.fromRGBO(255, 255, 255, 1),
            ),
          ),
        ),
      );
    }
  }
}

Image getIcon(int total) {
  if (total > 0) {
    return Image.asset(
      'assets/icons/picto_check.png',
      height: 20,
      width: 20,
      color: const Color.fromRGBO(50, 159, 91, 1),
    );
  }
  return Image.asset(
    'assets/icons/picto_croix.png',
    height: 20,
    width: 20,
    color: const Color.fromRGBO(95, 89, 84, 1),
  );
}
