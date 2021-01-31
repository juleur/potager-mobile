import 'package:meta/meta.dart';
import './../models/user_model.dart';

class NearestPotager {
  NearestPotager({
    @required this.user,
    @required this.legumesCount,
    @required this.fruitsCount,
    @required this.grainesCount,
    this.distance,
  });

  factory NearestPotager.fromJson(dynamic json) {
    return NearestPotager(
      user: User.fromJson(json['user']),
      fruitsCount: json['fruitsCount'] as int,
      legumesCount: json['legumesCount'] as int,
      grainesCount: json['grainesCount'] as int,
      distance: json['distance'] as double,
    );
  }
  final User user;
  final int fruitsCount, legumesCount, grainesCount;
  final double distance;
}
