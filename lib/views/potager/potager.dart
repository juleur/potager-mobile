import 'package:flutter/material.dart';

class PotagerView extends StatelessWidget {
  const PotagerView({Key key, @required this.potagerId}) : super(key: key);

  final int potagerId;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('test $potagerId'));
  }
}
