import 'package:meta/meta.dart';
import './../models/farmer_model.dart';
import './../models/user_model.dart';

class NearestPotager {
  NearestPotager({
    @required this.user,
    @required this.farmer,
    @required this.legumesCount,
    @required this.fruitsCount,
    @required this.grainesCount,
  });

  factory NearestPotager.fromJson(dynamic json) {
    return NearestPotager(
      user: User.fromJson(json['user']),
      farmer: Farmer.fromJson(json['farmer']),
      fruitsCount: json['fruitsCount'] as int,
      legumesCount: json['legumesCount'] as int,
      grainesCount: json['grainesCount'] as int,
    );
  }

  @override
  String toString() =>
      '{user: ${user.toString()}, {farmer: ${farmer.toString()}}, fruitsCount: $fruitsCount, grainesCount: $grainesCount, legumesCount: $legumesCount';

  final User user;
  final Farmer farmer;
  final int fruitsCount;
  final int legumesCount;
  final int grainesCount;
}
