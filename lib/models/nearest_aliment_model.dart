import './../models/aliment_model.dart';
import './../models/user_model.dart';

class NearestAliment {
  NearestAliment({this.user, this.aliment});

  factory NearestAliment.fromJson(dynamic json) {
    return NearestAliment(
      user: User.fromJson(json['user']),
      aliment: Aliment.fromJson(json['aliment']),
    );
  }
  final User user;
  final Aliment aliment;
}
