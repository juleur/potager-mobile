import 'package:flutter/material.dart';
import './../../../../models/nearest_potager_model.dart';
import './../../../../views/potager/potager.dart';

class CardPotager extends StatelessWidget {
  const CardPotager(this._np, {Key key}) : super(key: key);

  final NearestPotager _np;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute<PotagerView>(
          builder: (context) => PotagerView(potagerId: _np.user.id),
        ),
      ),
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  'https://placeimg.com/640/480/any',
                  height: 120,
                  fit: BoxFit.fill,
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
              child: Row(
                children: [
                  Image.asset(
                    'assets/icons/picto_geolocalisation.png',
                    width: 20,
                    height: 20,
                    color: const Color.fromRGBO(50, 159, 91, 1),
                  ),
                  const Text('2.9 km - Commune')
                ],
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
                          const Text('Fruits'),
                        ],
                      ),
                      Row(
                        children: [
                          getIcon(_np.legumesCount),
                          const Text('Légumes'),
                        ],
                      ),
                      Row(
                        children: [
                          getIcon(_np.grainesCount),
                          const Text('Graines'),
                        ],
                      )
                    ],
                  ),
                  const Spacer(),
                  Container(
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
                ],
              ),
            )
          ],
        ),
      ),
    );
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
