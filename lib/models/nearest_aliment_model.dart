import './../models/aliment_model.dart';
import './../models/farmer_model.dart';
import './../models/user_model.dart';

class NearestAliment {
  NearestAliment({this.user, this.farmer, this.aliment});

  factory NearestAliment.fromJson(dynamic json) {
    return NearestAliment(
      user: User.fromJson(json['user']),
      farmer: Farmer.fromJson(json['farmer']),
      aliment: Aliment.fromJson(json['aliment']),
    );
  }

  @override
  String toString() =>
      '{user: ${user.toString()}, farmer: ${farmer.toString()}, aliment: ${aliment.toString()}}';

  final User user;
  final Farmer farmer;
  final Aliment aliment;
}
